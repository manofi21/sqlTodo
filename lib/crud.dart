import 'package:sqflite/sqlite_api.dart';
import 'contact.dart';
import 'dbhelper.dart';

class DatabaseCreator {
  static const todoTable = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';
}

class CRUD {
  DbHelper dbHelper = new DbHelper();
  // Future<int> insert(Contact object) async {
  //   Database db = await dbHelper.initDb();
  //   int count = await db.insert('contact', object.toMap());
  //   return count;
  // }

  Future<int> insert(Contact todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''INSERT INTO ${DatabaseCreator.todoTable}
    (
      ${DatabaseCreator.name},
      ${DatabaseCreator.phone}
    )
    VALUES (?,?)''';
    List<dynamic> params = [todo.name, todo.phone];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  // Future<int> update(Contact object) async {
  //   Database db = await dbHelper.initDb();
  //   int count = await db.update('contact', object.toMap(),
  //       where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  Future<int> update(Contact todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.name} = ?, ${DatabaseCreator.phone}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [todo.name, todo.phone, todo.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  // Future<int> delete(int id) async {
  //   Database db = await dbHelper.initDb();
  //   int count = await db.delete('contact', where: 'id=?', whereArgs: [id]);
  //   return count;
  // }

  Future<int> delete(Contact todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''DELETE FROM ${DatabaseCreator.todoTable}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [todo.id];
    final result = await db.rawDelete(sql, params);
    return result;
  }

  // Future<List<ClassPenangkap>> getContactList() async {
  //   Database db = await dbHelper.initDb();
  //   List<Map<String, dynamic>> mapList =
  //       await db.query('contact', orderBy: 'name');
  //   int count = mapList.length;
  //   List<ClassPenangkap> contactList = List<ClassPenangkap>();
  //   for (int i = 0; i < count; i++) {
  //     contactList.add(ClassPenangkap.fromMap(mapList[i]));
  //   }
  //   return contactList;
  // }

  Future<List<Contact>> getContactList() async {
    Database db = await dbHelper.initDb();
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}''';
    final data = await db.rawQuery(sql);
    List<Contact> todos = List();

    for (final node in data) {
      final todo = Contact.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}
/* 
  Future<List<Contact>> getContactList() async {
    Database db = await dbHelper.initDb();
    List<Map<String,dynamic>> mapList = await db.query('contact', orderBy: 'name');
    int count = mapList.length;
    List<Contact> contactList = List<Contact>();
    for (int i = 0; i < count; i++) {
      contactList.add(Contact.fromMap(mapList[i]));
    }
    return contactList;
  }

  Future<int> delete(int id) async {
    Database db = await dbHelper.initDb();
    int count = await db.delete('contact', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<int> update(Contact object) async {
    Database db = await dbHelper.initDb();
    int count = await db.update('contact', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }
*/

/*
import 'package:sqflite/sqlite_api.dart';
import 'contact.dart';
import 'dbhelper.dart';

class DatabaseCreator {
  static const todoTable = 'todo';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';
}

class CRUD {
  Database db;
//insert,update,delete,getContacList
  DbHelper dbHelper = new DbHelper();

  Future<int> insert(Contact object) async {
    Database db = await dbHelper.initDb();
    int count = await db.insert('contact', object.toMap());
    return count;
  }

  Future<int> update(Contact object) async {
    Database db = await dbHelper.initDb();
    int count = await db.update('contact', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> updateTodo(Contact todo) async {
    final sql = '''UPDATE ${DatabaseCreator.todoTable}
    SET ${DatabaseCreator.name} = ?, ${DatabaseCreator.phone}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [todo.name, todo.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<int> delete(Contact todo) async {
    final sql = '''DELETE FROM ${DatabaseCreator.todoTable}
    WHERE ${DatabaseCreator.id} = ?
    ''';

    List<dynamic> params = [todo.id];
    final result = await db.rawUpdate(sql, params);
    return result;
  }

  Future<List<Contact>> getContactList() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.todoTable}''';
    final data = await db.rawQuery(sql);
    List<Contact> todos = List();

    for (final node in data) {
      final todo = Contact.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }
}
*/
