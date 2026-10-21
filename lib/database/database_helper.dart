
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/student.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            studentId TEXT NOT NULL UNIQUE,
            email TEXT NOT NULL,
            avatar TEXT
          )
        ''');
      },
    );
  }

  Future<List<Student>> getStudents() async {
    final db = await database;
    final result = await db.query('students', orderBy: 'id DESC');

    return result.map((map) => Student.fromMap(map)).toList();
  }

  Future<Student?> getStudentById(int id) async {
    final db = await database;
    final result = await db.query(
      'students',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return Student.fromMap(result.first);
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return db.insert('students', student.toMap());
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;

    return db.update(
      'students',
      student.toMap()..remove('id'),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;

    return db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
