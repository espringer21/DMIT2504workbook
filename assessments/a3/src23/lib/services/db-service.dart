// ignore_for_file: todo, avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls, file_names, unused_import

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      //TODO: Put your code here to complete this method.
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'stocks_database.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE stocks(symbol TEXT PRIMARY KEY, companyName TEXT, price REAL)",
          );
        },
        version: 1,
      );
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      //TODO: Put your code here to complete this method.
      final List<Map<String, dynamic>> stocks = await db!.query('stocks');
      print('stocks: $stocks');
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStocksFromDb() async {
    try {
      //TODO: Put your code here to complete this method.
      // Replace this return with valid data.
      final List<Map<String, dynamic>> stocks = await db!.query('stocks');
      return stocks;
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      //TODO: Put your code here to implement this method.
      await sqflitePackage.deleteDatabase(path);
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table.
      //Also specify the conflictAlgorithm.
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.
      await db.insert(
        'stocks',
        stock,
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to update stock info.
      await db.update(
        'stocks',
        stock,
        where: "id = ?",
        whereArgs: [stock['id']],
      );
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to delete a stock from the database.
      await db.delete(
        'stocks',
        where: "id = ?",
        whereArgs: [stock['id']],
      );
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}