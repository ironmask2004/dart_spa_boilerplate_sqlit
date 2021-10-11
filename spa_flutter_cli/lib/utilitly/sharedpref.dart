import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'dart:io' show Platform;
//import 'package:universal_io/io.dart';
import 'package:universal_io/io.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  static final _isLinux = Platform.isLinux;

  setStringValue(String key, String value) async {
    final storage = FlutterSecureStorage();

    if (_isLinux) {
      await storage.write(key: key, value: value, lOptions: LinuxOptions());
    } else {
      await storage.write(key: key, value: value);
    }
  }

  Future<String> getStringValue(String key) async {
    // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock, );

    final storage = FlutterSecureStorage();
    //print(Platform.operatingSystem);
    print('GET USER ID FROM SHARED SECURE STORAGE');
    print('------------------------------');
    print(_isLinux.runtimeType.toString());

    print('------------------------------');

    if (Platform.isLinux) {
      print("LILLLLLLLLLLLLLLLLLLLLLLLux");
      return (await storage.read(key: key, lOptions: LinuxOptions())) ?? "";
    } else {
      print('=======================================NNNNNNNot LINUX');
      return (await storage.read(key: key)) ?? "";
    }
  }

  Future<bool> containsKey(String key) async {
    //final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);

    final storage = FlutterSecureStorage();
    if (_isLinux) {
      return await storage.containsKey(key: key, lOptions: LinuxOptions());
    } else {
      return await storage.containsKey(key: key);
    }
  }

  removeValue(String key) async {
    final storage = FlutterSecureStorage();
    if (_isLinux) {
      return await storage.delete(key: key, lOptions: LinuxOptions());
    } else {
      return await storage.delete(key: key);
    }
  }

  removeAll() async {
    final storage = FlutterSecureStorage();

    if (_isLinux) {
      return await storage.deleteAll(lOptions: LinuxOptions());
    } else {
      return await storage.deleteAll();
    }
  }
}
