import 'dart:async';
import 'dart:math';
import 'package:record/record.dart';
import '../data/event_database.dart';
import '../models/sound_event.dart';
import 'sound_classifier.dart';

class MonitorService {
  final AudioRecorder _recorder = AudioRecorder();
  final SoundClassifier _classifier = SoundClassifier();
  StreamSubscription<Uint8List>? _subscription;
  bool _running = false;
  bool get isRunning => _running;

  Future<void> initialize() => _classifier.load();

  Future<void> start({
    required void Function(SoundEvent event) onEvent,
    required void Function(String message) onStatus,
  }) async {
    if (_running) return;
    if (!await _recorder.hasPermission()) {
      throw StateError('Microphone permission was not granted.');
    }
    if (!_classifier.isReady) {
      throw StateError('YAMNet model is not installed. Follow docs/MODEL_SETUP.md.');
    }
    final stream = await _recorder.startStream(const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 16000,
      numChannels: 1,
    ));
    _running = true;
    final buffer = <double>[];
    _subscription = stream.listen((bytes) async {
      for (var i = 0; i + 1 < bytes.length; i += 2) {
        final value = (bytes[i] & 0xff) | (bytes[i + 1] << 8);
        final signed = value >= 32768 ? value - 65536 : value;
        buffer.add(signed / 32768.0);
      }
      while (buffer.length >= 15600) {
        final frame = buffer.sublist(0, 15600);
        buffer.removeRange(0, 15600);
        final peak = frame.map((v) => v.abs()).fold<double>(0, max);
        try {
          final prediction = await _classifier.classify(frame);
          if (prediction != null && prediction.score >= 0.45) {
            final event = SoundEvent(
              id: null,
              label: prediction.label,
              confidence: prediction.score,
              timestamp: DateTime.now(),
              peakLevel: peak,
            );
            await EventDatabase.instance.insert(event);
            onEvent(event);
          }
        } catch (e) {
          onStatus('Audio inference error: $e');
        }
      }
    }, onError: (Object e) => onStatus('Microphone stream error: $e'));
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    if (await _recorder.isRecording()) await _recorder.stop();
    _running = false;
  }

  Future<void> dispose() async {
    await stop();
    await _recorder.dispose();
    _classifier.close();
  }
}
