import 'dart:async';
import 'package:path/path.dart';
import 'package:quiz_app_flutter_sqflite/model/score.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  static late Database database; // Use 'late' to indicate late initialization

  DbManager() {
    createDatabase();
  }

  Future<void> createDatabase() async {
    String path = join(await getDatabasesPath(), 'score.db');
    database = await openDatabase(path, version: 1, onCreate: initDatabase);
  }

  Future<void> initDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE score(id INTEGER PRIMARY KEY AUTOINCREMENT, nameUser TEXT , categories TEXT, score INTEGER, date TEXT, totalAnswer INTEGER, totalQuestion INTEGER )');
  }

  Future<int> addUserScore(Score score) async {
    await createDatabase();
    return await database.insert('score', score.toJson());
  }

  Future<int> deleteScore(int id) async {
    await createDatabase();
    return await database.delete('score', where: "id = ?", whereArgs: [id]);
  }

  Future<List<Score>> getUserScore() async {
    List<Score> arrUserScore = [];
    await createDatabase();
    var res = await database.query('score');
    for (var element in res) {
      arrUserScore.add(Score.fromJson(element));
    }
    return arrUserScore;
  }
}
