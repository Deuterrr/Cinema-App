import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  static const String locationKey = 'currentLocation';

  static Future<void> saveLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(locationKey, location);
  }

  static Future<String> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(locationKey) ?? 'All Cinemas';
  }
}
