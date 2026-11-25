import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sound_event.dart';

class EventDatabase {
  EventDatabase._();
  static final EventDatabase instance = EventDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    _db = await openDatabase(
      p.join(dir.path, 'echoguard.db'),
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          label TEXT NOT NULL,
          confidence REAL NOT NULL,
          timestamp TEXT NOT NULL,
          peak_level REAL NOT NULL
        )
      '''),
    );
    return _db!;
  }

  Future<void> insert(SoundEvent event) async {
    final db = await database;
    final map = event.toMap()..remove('id');
    await db.insert('events', map);
  }

  Future<List<SoundEvent>> recent({int limit = 100}) async {
    final db = await database;
    final rows = await db.query('events', orderBy: 'timestamp DESC', limit: limit);
    return rows.map(SoundEvent.fromMap).toList();
  }

  Future<void> clear() async => (await database).delete('events');
}
