import 'package:spa_server/spa_server.dart';


class UserApi {
  String store;
  Database db;

  UserApi(this.db, this.store);

  Handler get router {
    final router = Router();

    router.get('/', (Request req) async {
      final authDetails = req.context['authDetails'] as JWT;

      print('authDetails.subject.toString ' + authDetails.subject.toString());

      final ResultSet resultSet =
      db.select('SELECT * FROM Users WHERE _id = \"' + authDetails.subject.toString() + "\"");
      if (resultSet.isEmpty) {
        return Response.forbidden('Incorrect user and/or password');

      }
      print(resultSet.toString());

      final   user = await ({'id': resultSet.first['id'] , 'email': resultSet.first['email'] ,'salt': resultSet.first['salt'] } );
     // final user = resultSet.toList ();
     // final user = await store.findOne(
     //    where.eq('_id', ObjectId.fromHexString(authDetails.subject.toString())) )
      return Response.ok('{ "email": "${user['email']}" }', headers: {
        'content-type': 'application/json',
      });
    });

    final handler =
        Pipeline().addMiddleware(checkAuthorisation()).addHandler(router);

    return handler;
  }
}
