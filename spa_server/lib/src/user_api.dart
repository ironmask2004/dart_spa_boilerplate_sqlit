import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

import './utils.dart';

class UserApi {
  String store;
  Database db;

  UserApi(this.db, this.store);

  Handler get router {
    final router = Router();

    router.get('/', (Request req) async {
      final authDetails = req.context['authDetails'] as JWT;

      final ResultSet resultSet =
      db.select('SELECT id FROM Usres WHERE _id = ' + authDetails.subject.toString());
      if (resultSet.isEmpty) {
        return Response.forbidden('Incorrect user and/or password');

      }

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
