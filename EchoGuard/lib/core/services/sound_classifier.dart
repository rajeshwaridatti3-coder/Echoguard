import 'dart:math';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class SoundPrediction {
  const SoundPrediction(this.label, this.score);
  final String label;
  final double score;
}

/// YAMNet adapter. Expects mono Float32 PCM at 16 kHz, 15,600 samples
/// (approximately 0.975 seconds). The app deliberately fails closed when
/// model assets are absent instead of inventing AI predictions.
class SoundClassifier {
  Interpreter? _interpreter;
  List<String> _labels = [];

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset('assets/models/yamnet.tflite');
    final raw = await rootBundle.loadString('assets/labels/yamnet_class_map.csv');
    _labels = raw.split('\n').skip(1).map((line) {
      final parts = line.split(',');
      return parts.length >= 3 ? parts.sublist(2).join(',').trim() : '';
    }).toList();
  }

  bool get isReady => _interpreter != null;

  Future<SoundPrediction?> classify(List<double> waveform) async {
    final interpreter = _interpreter;
    if (interpreter == null) return null;
    if (waveform.length != 15600) {
      throw ArgumentError('YAMNet expects exactly 15,600 mono samples at 16 kHz.');
    }
    final outputShape = interpreter.getOutputTensor(0).shape;
    final output = List.generate(outputShape[0], (_) => List<double>.filled(outputShape[1], 0));
    interpreter.run([waveform], output);
    final scores = output.first;
    var best = 0;
    for (var i = 1; i < scores.length; i++) {
      if (scores[i] > scores[best]) best = i;
    }
    if (best >= _labels.length) return null;
    return SoundPrediction(_labels[best], scores[best]);
  }

  void close() => _interpreter?.close();
}
