class SoundEvent {
  const SoundEvent({
    required this.id,
    required this.label,
    required this.confidence,
    required this.timestamp,
    required this.peakLevel,
  });

  final int? id;
  final String label;
  final double confidence;
  final DateTime timestamp;
  final double peakLevel;

  Map<String, Object?> toMap() => {
    'id': id,
    'label': label,
    'confidence': confidence,
    'timestamp': timestamp.toIso8601String(),
    'peak_level': peakLevel,
  };

  factory SoundEvent.fromMap(Map<String, Object?> map) => SoundEvent(
    id: map['id'] as int?,
    label: map['label'] as String,
    confidence: (map['confidence'] as num).toDouble(),
    timestamp: DateTime.parse(map['timestamp'] as String),
    peakLevel: (map['peak_level'] as num).toDouble(),
  );
}
