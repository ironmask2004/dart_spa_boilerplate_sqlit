import 'package:spa_server/spa_server.dart';

class UserApi {
  String store;
  Database db;
  UserApi(this.db, this.store);
  Handler get router {
    final router = Router();
    router.get('/info/', (Request req) async {
      final authDetails = req.context['authDetails'] as JWT;
      print('authDetails.subject.toString ' + authDetails.subject.toString());

      User Curr_user = await User.findById( authDetails.subject.toString(), db);
       print ("founded_user------:" + Curr_user.email!);
          return Response.ok('{ "email": "${Curr_user.email}" }', headers: {
        'content-type': 'application/json',
      });
    });

   /* router.post('/', (Request req) async {
      final authDetails = req.context['authDetails'] as JWT;
      print('authDetails.subject.toString ' + authDetails.subject.toString());

      User Curr_user = await User.findById( authDetails.subject.toString(), db);
      print ("founded_user------:" + Curr_user.email!);
      return Response.ok('{ "email": "${Curr_user.email}" }', headers: {
        'content-type': 'application/json',
      });
    });*/

    final handler =
        Pipeline().addMiddleware(checkAuthorisation()).addHandler(router);
    return handler;
  }
}
