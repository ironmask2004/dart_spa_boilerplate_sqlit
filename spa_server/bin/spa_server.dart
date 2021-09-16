import 'package:path/path.dart';
import 'package:spa_server/spa_server.dart';
import 'package:spa_server/src/database_api.dart';
import 'package:sqlite3/sqlite3.dart';


void main(List<String> arguments) async {
  const secret = Env.secretKey;
  const port = Env.serverPort;
  final dbname =   'Spa_database.db' ;

  final tokenService = TokenService(RedisConnection(), secret);

  //await db.openDB();
  // open the database
  //Future<Database> database= openDB();
  var dbSqlite_api1 = dbSqlite_api(dbname);

  print('Connected to our database');

  await tokenService.start(Env.redisHost, int.parse(Env.redisPort));
  print('Token Service running...');

  final store = 'users'  ;
  final app = Router();

  app.mount('/auth/', AuthApi(dbSqlite_api1.MyDatabase,store, secret, tokenService).router);

  app.mount('/users/', UserApi(dbSqlite_api1.MyDatabase,store).router);

  app.mount('/assets/', StaticAssetsApi('public').router);

  app.all('/<name|.*>', fallback('public/index.html'));

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addMiddleware(handleAuth(secret))
      .addHandler(app);

  await serve(handler, 'localhost', int.parse(Env.serverPort));

  print('HTTP Service running on port $port');
}
