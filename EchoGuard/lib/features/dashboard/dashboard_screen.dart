import 'package:flutter/material.dart';
import '../../core/data/event_database.dart';
import '../../core/models/sound_event.dart';
import '../../core/services/monitor_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MonitorService _monitor = MonitorService();
  List<SoundEvent> _events = [];
  bool _loading = true;
  bool _starting = false;
  String _status = 'Preparing on-device sound recognition…';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _monitor.initialize();
      _status = 'Model ready. Monitoring is off.';
    } catch (e) {
      _status = 'Model setup required. See docs/MODEL_SETUP.md';
    }
    _events = await EventDatabase.instance.recent();
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _toggle() async {
    if (_monitor.isRunning) {
      await _monitor.stop();
      setState(() => _status = 'Monitoring stopped.');
      return;
    }
    setState(() => _starting = true);
    try {
      await _monitor.start(
        onEvent: (event) {
          if (!mounted) return;
          setState(() {
            _events.insert(0, event);
            if (_events.length > 50) _events.removeLast();
            _status = 'Detected: ${event.label}';
          });
        },
        onStatus: (message) {
          if (mounted) setState(() => _status = message);
        },
      );
      setState(() => _status = 'Listening for supported sound events…');
    } catch (e) {
      setState(() => _status = e.toString().replaceFirst('Bad state: ', ''));
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  void dispose() {
    _monitor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final running = _monitor.isRunning;
    return Scaffold(
      appBar: AppBar(title: const Text('EchoGuard'), actions: [
        IconButton(
          tooltip: 'Refresh history',
          onPressed: () async => setState(() async {
            _events = await EventDatabase.instance.recent();
          }),
          icon: const Icon(Icons.refresh),
        )
      ]),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(padding: const EdgeInsets.all(20), children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.graphic_eq, size: 36),
                  const SizedBox(height: 12),
                  const Text('Environmental sound intelligence',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_status),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: _starting ? null : _toggle,
                    icon: Icon(running ? Icons.stop : Icons.mic),
                    label: Text(_starting ? 'Starting…' : running ? 'Stop monitoring' : 'Start monitoring'),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Recent detections', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                Text('${_events.length} events'),
              ]),
              const SizedBox(height: 10),
              if (_events.isEmpty)
                const Card(child: Padding(
                  padding: EdgeInsets.all(22),
                  child: Text('No sound events recorded yet. Start monitoring after installing the model.'),
                ))
              else
                ..._events.map((e) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.notifications_active_outlined)),
                    title: Text(e.label),
                    subtitle: Text('${e.timestamp.toLocal()}  •  ${(e.confidence * 100).toStringAsFixed(1)}% confidence'),
                    trailing: Text(e.peakLevel.toStringAsFixed(2)),
                  ),
                )),
            ]),
    );
  }
}
