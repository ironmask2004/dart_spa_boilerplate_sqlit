import 'package:spa_server/spa_server.dart';

void main(List<String> arguments) async {
  const secret = Env.secretKey;
  const port = Env.serverPort;
  const dbname = Env.sqliteName;
  const serverHost = Env.serverHost;
  const serverPort = Env.serverPort;

  final tokenService = TokenService(RedisConnection(), secret);

  //await db.openDB();
  // open the database
  //Future<Database> database= openDB();
  var dbSqlite_api1 = dbSqlite_api(dbname);

  print('Connected to our database');

  await tokenService.start(Env.redisHost, int.parse(Env.redisPort));
  print('Token Service running...');

  final store = 'users';
  final app = Router();
  app.mount('/auth/',
      AuthApi(dbSqlite_api1.MyDatabase, store, secret, tokenService).router);
  app.mount('/users/', UserApi(dbSqlite_api1.MyDatabase, store).router);
  app.mount('/assets/', StaticAssetsApi('public').router);
  app.all('/<name|.*>', fallback('public/index.html'));

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addMiddleware(handleAuth(secret))
      .addHandler(app);

  print('HTTP Service running on port $port');
  await serve(handler, serverHost, int.parse(serverPort));

  //await serve(app, 'localhost', int.parse(serverPort));
}
