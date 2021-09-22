import 'package:envify/envify.dart';

part 'config.g.dart';
///////////////////
///------>>>>  flutter pub run build_runner clean
///------>>>>  flutter pub run build_runner build
/// //////

@Envify()
abstract class Env {
 // static const secretKey = _Env.secretKey;
 // static const sqliteName = _Env.sqliteName;
 // static const redisHost = _Env.redisHost;
 // static const   redisPort = _Env.redisPort;
  static const   serverHost = _Env.serverHost;
  static const   serverPort = _Env.serverPort;
   static const baseUrl = _Env.baseUrl ;

 }