import 'package:hive/hive.dart';

class HiveStorage {
  static const String _boxName = 'authBox';

  static Future<void> saveToken(String token) async {
    var box = await Hive.openBox(_boxName);
    await box.put('token', token);
  }

  static Future<String?> getToken() async {
    var box = await Hive.openBox(_boxName);
    return box.get('token');
  }

  static Future<void> clearToken() async {
    var box = await Hive.openBox(_boxName);
    await box.delete('token');
  }
}