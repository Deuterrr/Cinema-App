import 'package:cinema_application/data/helpers/dbhelper.dart';

class DatabaseQueriesHelper {
  final DatabaseHelper dbQHelper = DatabaseHelper();

  //### Account Helper ###//
  //# - users - #//

      // submit login
  Future<bool> submitLogin({required String email, required String password}) async {
    final db = await dbQHelper.database;

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
    await dbQHelper.insertRow(table, newUser);
    return true;
  }
  
      // get existing email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await dbQHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  //# - login - #//

      // insert the last login account (username)
  Future<bool> submitLastLogin(String username) async {
    try {
      final data = {'username': username};
      final table = "login";
      await dbQHelper.insertRow(table, data);
      return true;
    } catch (e) {
      return false;
    }
  }

      // get the last login account
  Future<String?> getLastLogin() async {
    final db = await dbQHelper.database;
    final result = await db.query('login', orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      print("Last login account found: ${result.first['username']}");
      return result.first['username'] as String?;
    }
    return null;
  }

      // emptying last login (using delete)
  Future<int> deleteLastLogin(String email) async {
    try {
      final db = await dbQHelper.database;
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