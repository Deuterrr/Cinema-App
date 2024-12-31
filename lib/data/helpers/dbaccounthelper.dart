import 'package:cinema_application/data/helpers/dbhelper.dart';

class AccountHelper {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // submit login
  Future<bool> submitLogin({required String email, required String password}) async {
    final db = await dbHelper.database;

    // find the user by email and check if password matches
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  // submit register
  Future<bool> submitRegister({String? fullName, required String email, required String password, String? phoneNumber}) async {
    // check existing email
    final existingUser = await getUserByEmail(email);
    if (existingUser != null) {
      return false;
    }

    String defaultProfileImage = 'assets/images/pngwing.com.png';

    final table = "users";
    final newUser = {
      'name': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profile_image': defaultProfileImage
    };
    await dbHelper.insertRow(table, newUser);
    return true;
  }
  
  // existing email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  //# - - - #//

  // insert the last login account (username)
  Future<bool> submitLastLogin(String username) async {
    try {
      final data = {'username': username};
      final table = "login";
      await dbHelper.insertRow(table, data);
      print("Inserted login account: $username");
      return true;
    } catch (e) {
      print("Error saving login account: $e");
      return false;
    }
  }

  // get the last login account
  Future<String?> getLastLogin() async {
    final db = await dbHelper.database;
    final result = await db.query('login', orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      print("Last login account found: ${result.first['username']}");
      return result.first['username'] as String?;
    }
    final result1 = await db.query('login');
    print("Current login table contents: $result1");
    return null;
  }

  // emptying last login (using delete)
  Future<int> deleteLastLogin(String email) async {
    try {
      final db = await dbHelper.database;
      final result = await db.delete(
        'login',
        where: 'username = ?',
        whereArgs: [email],
      );
      print("User deleted with id: $result");
      return result;
    } catch (e) {
      print("Error deleting user: $e");
      return -1;
    }
  }

}