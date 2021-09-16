import 'package:path/path.dart';
import 'package:spa_server/spa_server.dart';
import 'package:spa_server/src/database_api.dart';
import 'package:sqlite3/sqlite3.dart';


void main(List<String> arguments) async {
  const secret = Env.secretKey;
  const port = Env.serverPort;
  final db = dbSqlite_api( 'Spa_database.db').MyDatabase;

  final tokenService = TokenService(RedisConnection(), secret);

  //await db.openDB();
  // open the database
  //Future<Database> database= openDB();

  print('Connected to our database');

  await tokenService.start(Env.redisHost, int.parse(Env.redisPort));
  print('Token Service running...');

  final store = 'users'  ;
  final app = Router();

  app.mount('/auth/', AuthApi(db,store, secret, tokenService).router);

  app.mount('/users/', UserApi(db,store).router);

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
