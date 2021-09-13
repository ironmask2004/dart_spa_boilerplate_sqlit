import 'package:envify/envify.dart';

part 'config.g.dart';


@Envify()
abstract class Env {
  static const secretKey = _Env.secretKey;
  static const mongoUrl = _Env.mongoUrl;
  static const redishost = _Env.redishost;
  static const   redisport = _Env.redisport;
  static const   serverport = _Env.serverport;
 }