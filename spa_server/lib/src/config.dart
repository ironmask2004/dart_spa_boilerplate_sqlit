import 'package:envify/envify.dart';

part 'config.g.dart';

@Envify()
abstract class Env {
  static const secretKey = _Env.secretKey;
  static const mongoUrl = _Env.mongoUrl;
  static const redisHost = '127.0.0.1';
  static const   redisPort = 9999;
  static const   serverPort = 9190;
 }
