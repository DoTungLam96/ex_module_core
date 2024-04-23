import 'package:ex_module_core/ex_module_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  bool containsKey(String key) => sharedPreferences.containsKey(key);

  Future<bool?>? putStringList(String key, List<String> value) =>
      sharedPreferences.setStringList(key, value);
  List<String>? getStringList(String key) =>
      sharedPreferences.getStringList(key);

  Future<bool?>? putBool(String key, bool value) =>
      sharedPreferences.setBool(key, value);

  bool? getBool(String key) => sharedPreferences.getBool(key);

  Future<bool?>? putString(String key, String value) =>
      sharedPreferences.setString(key, value);

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  Future<bool?>? putInt(String key, int value) =>
      sharedPreferences.setInt(key, value);

  int? getInt(String key) => sharedPreferences.getInt(key);

  Future? clear() => sharedPreferences.clear();

  Future<bool> remove(String key) => sharedPreferences.remove(key);

  // Function to save data with an expiration date to SharedPreferences
  Future<bool> saveDataWithExpiration(
      String data, Duration expirationDuration) async {
    try {
      DateTime expirationTime = DateTime.now().add(expirationDuration);
      await sharedPreferences.setString(kDataCaching, data);
      await sharedPreferences.setString(
          kExpiration, expirationTime.toIso8601String());
      print('Data saved to SharedPreferences.');
      return true;
    } catch (e) {
      print('Error saving data to SharedPreferences: $e');
      return false;
    }
  }

  // Function to get data from SharedPreferences if it's not expired
  Future<String?> getDataIfNotExpired() async {
    try {
      String? data = sharedPreferences.getString(kDataCaching);
      String? expirationTimeStr = sharedPreferences.getString(kExpiration);
      if (data == null || expirationTimeStr == null) {
        print('No data or expiration time found in SharedPreferences.');
        return null;
      }

      DateTime expirationTime = DateTime.parse(expirationTimeStr);
      if (expirationTime.isAfter(DateTime.now())) {
        print('Data has not expired.');
        // The data has not expired.
        return data;
      } else {
        await sharedPreferences.remove(kDataCaching);
        await sharedPreferences.remove(kExpiration);
        print('Data has expired. Removed from SharedPreferences.');
        return null;
      }
    } catch (e) {
      print('Error retrieving data from SharedPreferences: $e');
      return null;
    }
  }

  // Function to clear data from SharedPreferences
  Future<void> clearData() async {
    try {
      await sharedPreferences.remove(kDataCaching);
      await sharedPreferences.remove(kExpiration);
      print('Data cleared from SharedPreferences.');
    } catch (e) {
      print('Error clearing data from SharedPreferences: $e');
    }
  }
}
