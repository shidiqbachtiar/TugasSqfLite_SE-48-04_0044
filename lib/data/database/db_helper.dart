import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const tabelName = 'nama';
  static const _createTable =
      '''
    CREATE TABLE $tabelName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT NOT NULL,
      stok INTEGER NOT NULL
    )
  ''';

  Future<Database> get database => openDatabase(
    'Barang.db',
    version: 3,
    onCreate: (db, _) => db.execute(_createTable),
    onUpgrade: (db, oldVersion, _) async {
      if (oldVersion < 3) {
        await db.execute('ALTER TABLE $tabelName RENAME TO nama_lama');
        await db.execute(_createTable);
        // Skema lama menyimpan nama barang tanpa stok.
        await db.execute('''
          INSERT INTO $tabelName (id, nama, stok)
          SELECT id, name, 0 FROM nama_lama
        ''');
        await db.execute('DROP TABLE nama_lama');
      }
    },
  );
}
