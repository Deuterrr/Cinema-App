import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // Get the database (combined logic)
  // Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   String dbPath = await getDatabasesPath();
  //   String path = join(dbPath, 'cinemaapp.db');

  //   print("Database path: $path");

  //   try {
  //     bool dbExists = await File(path).exists();
  //     if (dbExists) {
  //       print("Database already exists at $path");
  //     } else {
  //       print("Creating new database at $path");
  //     }

  //     // Open or create the database
  //     _database = await openDatabase(
  //       path,
  //       version: 1,
  //       readOnly: false, // Set to false for write operations
  //       onCreate: (db, version) async {
  //         await db.execute('''
  //           CREATE TABLE users (
  //             id INTEGER PRIMARY KEY AUTOINCREMENT,
  //             name TEXT NOT NULL,
  //             email TEXT NOT NULL UNIQUE,
  //             password TEXT NOT NULL,
  //             phoneNumber TEXT NOT NULL UNIQUE,
  //             created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  //             profile_image BLOB
  //           );
  //           CREATE TABLE login (
  //             id INTEGER PRIMARY KEY AUTOINCREMENT,
  //             username TEXT NOT NULL
  //           )
  //         ''');
  //         print("Database and table created");
  //       },
  //     );
  //   } catch (e) {
  //     print("Error opening or creating database: $e");
  //   }

  //   return _database!;
  // }


  //Buat development ajaaa
  // Harus diapus atau dikomen nanti
  Future<Database> get database async {
    if (_database != null) return _database!;

    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'cinemaapp.db');

    print("Database path: $path");

    try {
      // Delete the database if it already exists
      bool dbExists = await File(path).exists();
      if (dbExists) {
        print("Deleting existing database at $path");
        await deleteDatabase(path); // Delete the database
      }

      // Open or create the database
      _database = await openDatabase(
        path,
        version: 1,
        readOnly: false, // Set to false for write operations
        onCreate: (db, version) async {
          // Execute your table creation script
          await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT NOT NULL UNIQUE,
              password TEXT NOT NULL,
              phoneNumber TEXT NOT NULL UNIQUE,
              created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
              profile_image BLOB
            );
          ''');
          await db.execute('''
            CREATE TABLE login (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username TEXT NOT NULL UNIQUE
            );
          ''');
          print("Database and tables created");
        },
      );
    } catch (e) {
      print("Error opening or creating database: $e");
    }

    return _database!;
  }


  // Check if the account is already exist (sign up).
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

  // Insert a new user into users table
  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      final result = await db.insert('users', user);
      return result;
    } catch (e) {
      return -1; //indicate failure
    }
  }
  
  // Get all info about user in users table
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await database; // Open the database connection
      final List<Map<String, dynamic>> result = await db.query('users');

      print("All users: $result");
      return result; // Return the list of all users
    } catch (e) {
      print("Error retrieving users: $e");
      return []; // Return an empty list on error
    }
  }

  // Insert the account for last login
  Future<int> insertLogin(Map<String, dynamic> email) async {
    try {
      final db = await database;
      final result = await db.insert('login', email);
      return result;
    } catch (e) {
      return -1; // Return -1 to indicate failure
    }
  }

  // Delete the account from last login
  Future<int> deleteLogin(String email) async {
  try {
    final db = await database;
    final result = await db.delete(
      'login',
      where: 'username = ?',
      whereArgs: [email],
    );
    print("User deleted with id: $result");
    return result; // Returns the number of rows affected
  } catch (e) {
    print("Error deleting user: $e");
    return -1; // Return -1 to indicate failure
  }
}

  // Update a user's details
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a user
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Close the database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
    print("Database closed.");
  }


}
