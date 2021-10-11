import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: key, value: value);
  }

  Future<String> getStringValue(String key) async {
    final storage = FlutterSecureStorage();

    return (await storage.read(key: key)) ?? "";
  }

  Future<bool> containsKey(String key) async {
    final storage = FlutterSecureStorage();

    return storage.containsKey(key: key);
  }

  removeValue(String key) async {
    final storage = FlutterSecureStorage();

    return await storage.delete(key: key);
  }

  removeAll() async {
    final storage = FlutterSecureStorage();

    return storage.deleteAll();
  }
}
