import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import '../models/tasks.dart';

class TaskService {
  static TaskService instance = TaskService._constructor();
  static Database? _db;

  final String _tasksTableName = "task";
  final String _tasksIdColumnname = "id";
  final String _tasksTitleColumnname = "title";
  final String _tasksDataColumnname = "data";
  final String _tasksDuetoColumnname = "dueto";
  final String _tasksTextColumnname = "text";
  final String _tasksStatusColumnname = "status";

  TaskService._constructor();
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await getDatabase();
    }

    return _db!;
  }

  Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'todo_db.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE $_tasksTableName(
          $_tasksIdColumnname INTEGER PRIMARY KEY AUTOINCREMENT,
          $_tasksTitleColumnname TEXT NOT NULL,
          $_tasksDataColumnname TEXT NOT NULL,
          $_tasksDuetoColumnname TEXT NOT NULL,
          $_tasksTextColumnname TEXT NOT NULL,
          $_tasksStatusColumnname INTEGER NOT NULL
        )''',
        );
      },
    );
    return database;
  }

  void addTask(String title, String text, String date) async {
    final db = await database;
    var nowDate = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString();
    db.insert(
      _tasksTableName,
      {
        _tasksTitleColumnname: title,
        _tasksTextColumnname: text,
        _tasksDataColumnname: nowDate,
        _tasksDuetoColumnname: date,
        _tasksStatusColumnname: 0,
      },
    );
  }

  Future<List<Tasks>> getTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    print(data);
    return data.map((e) => Tasks.fromMap(e)).toList();
  }

  Future<void> updateTask(int id, int status) async {
    final db = await database;
    db.update(
      _tasksTableName,
      {_tasksStatusColumnname: status},
      where: '$_tasksIdColumnname = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    db.delete(
      _tasksTableName,
      where: '$_tasksIdColumnname = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllTasks() async {
    final db = await database;
    db.delete(_tasksTableName);
  }

  Future<List<Tasks>> getDoneTasks() async {
    final db = await database;
    final data = await db.query(
      _tasksTableName,
      where: '$_tasksStatusColumnname = ?',
      whereArgs: [1],
    );
    return data.map((e) => Tasks.fromMap(e)).toList();
  }

  Future<List<Tasks>> getNotDoneTasks() async {
    final db = await database;
    final data = await db.query(
      _tasksTableName,
      where: '$_tasksStatusColumnname = ?',
      whereArgs: [0],
    );
    return data.map((e) => Tasks.fromMap(e)).toList();
  }

}
