import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBservice {
  static final DBservice _instance = DBservice._internal();
  Database? _db;
  DBservice._internal();

  factory DBservice() {
    return _instance;
  }

    Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dogs_table (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
  }


    Future<void> insertDog(Dog dog) async {
      final db = await _initDB();

      await db.insert(
        'dogs_table',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }


    Future<List<Dog>> getDogs() async {
      final Database db = await _initDB();

      final List<Map<String, dynamic>> maps = await db.query('dogs_table');

      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    Future<void> updateDog(Dog dog) async {
      final db = await _initDB();

      await db.update(
        'dogs_table',
        dog.toMap(),
        where: "id = ?",
        whereArgs: [dog.id],
      );
    }

    Future<void> deleteDog(int id) async {
      final db = await _initDB();

      await db.delete(
        'dogs_table',
        where: "id = ?",
        whereArgs: [id],
      );
    }

    var fido = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    
  void testDB() async{
    await insertDog(fido);
    print(await getDogs());

    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );

    await updateDog(fido);
    print(await getDogs());

    await deleteDog(fido.id);
    print(await getDogs());
  }

   Future<void> close() async {
    final db = await _initDB();
    await db.close();
  }

}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
