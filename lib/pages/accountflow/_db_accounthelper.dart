import 'package:cinema_application/pages/__dbhelper.dart';

class AccountHelper {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // For login
  Future<bool> loginUser({required String email, required String password}) async {
    final db = await dbHelper.database; // Assuming you're accessing the database here

    // Query to find the user by email and check if password matches
    final result = await db.query(
      'users', // Replace with your actual table name
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  // Insert the last login account (username)
Future<bool> saveLoginAccount(String username) async {
  try {
    final data = {'username': username};
    await dbHelper.insertLogin(data);
    print("Inserted login account: $username");
    return true;
  } catch (e) {
    print("Error saving login account: $e");
    return false;
  }
}

    // Get the last login account
  Future<String?> getLastLoginAccount() async {
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

  Future<bool> registerUser({
    String? fullName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    // Check if the email is already registered
    final existingUser = await dbHelper.getUserByEmail(email);
    if (existingUser != null) {
      return false; // Email already exists
    }

    String defaultProfileImage = 'assets/images/pngwing.com.png';

    // Add the user to the database
    final newUser = {
      'name': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profile_image': defaultProfileImage
    };

    await dbHelper.insertUser(newUser);
    return true;
  }
}
