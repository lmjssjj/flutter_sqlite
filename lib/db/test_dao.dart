import 'package:fluttersqlite/db/dao.dart';
import 'package:fluttersqlite/db/database_helper.dart';
import 'package:fluttersqlite/model/test_model.dart';
import 'package:sqflite/sqflite.dart';

class TestDao extends Dao {
  /*数据库插入*/
  rawInsert(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, numb) VALUES("s", 1234, 456.789)');
      print('inserted1: $id1');

      int id2 = await txn.rawInsert(
          'INSERT INTO Test(name, value, numb) VALUES(?, ?, ?)',
          [test.name, test.value, test.numb]);
      print('inserted2: $id2');
    });
    db.close();
  }

  rawUpdate(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    int count = await db.rawUpdate(
        'UPDATE Test SET name = ?, value = ? WHERE name = ?',
        [test.name, '9876', 'some name']);
    print('updated: $count');
    db.close();
  }

  rawQuery() async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    List<Map> list = await db.rawQuery('SELECT * FROM Test');
    print(list);
    db.close();
  }

  count() async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    int count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM Test'));
//    assert(count == 2);
    db.close();
  }

  rawDelete() async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    int count =
        await db.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    assert(count == 1);
    print(count);
    db.close();
  }

  insert(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    test.id = await db.insert("Test", test.toMap());
    db.close();
    return test;
  }

  select(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    List<Map> maps = await db.query("Test",
        columns: ["name", "value", "numb"],
        where: 'id = ?',
        whereArgs: [test.id]);
    if (maps.length > 0) {
//      return Test.fromMap(maps.first);
    }
    return null;
  }

  update(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    return await db
        .update("Test", test.toMap(), where: 'id = ?', whereArgs: [test.id]);
  }

  delete(Test test) async {
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    return await db.delete("Test", where: 'id = ?', whereArgs: [test.id]);
  }

  inserts(List<Test> datas) async{
    Database db = await DatabaseHelper.mDatabaseHelper.database;
    var batch = db.batch();
    batch.insert('Test', {'name': 'item'});
    batch.update('Test', {'name': 'new_item'}, where: 'name = ?', whereArgs: ['item']);
    batch.delete('Test', where: 'name = ?', whereArgs: ['item']);
    var results = await batch.commit();
  }
}
