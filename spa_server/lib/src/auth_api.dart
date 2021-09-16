import 'dart:convert';
import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:objectid/objectid.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';
import 'token_service.dart';
import 'utils.dart';

class AuthApi {
  String store;
  String secret;
  TokenService tokenService;
  Database db;
  AuthApi(this.db, this.store, this.secret, this.tokenService);

  Router get router {
    final router = Router();

    router.post('/register', (Request req) async {
      final payload = await req.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Ensure email and password fields are present
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: 'Please provide your email and password');
      }

      // Ensure user is unique
      //final user = await store_findOne(where.eq('email', email));
      print(db.toString());
      final ResultSet resultSet =
          db.select('SELECT id FROM Users WHERE email = \"' + email + '\"');
      if (resultSet.isNotEmpty) {
        return Response(HttpStatus.badRequest, body: 'User already exists');
      }

      // Create user
      //final authDetails = req.context['authDetails'] as JWT;
      //print (authDetails.subject.toString());
      final _id = ObjectId().toString();
      final salt = generateSalt();
      final hashedPassword = hashPassword(password, salt);
      try {
        var stmt = db.prepare(
            'INSERT INTO Users (email, password,salt,_id ) VALUES (?,?,?, ?)');

        stmt.execute([email, hashedPassword, salt, _id]);

        stmt.dispose();
      } catch (error) {
        print(' error while adding user  ' + error.toString());
        return Response(HttpStatus.badRequest, body: 'error while adding user');
      }
      return Response.ok('Successfully registered user');
    });

    ///------ LOGiN
    router.post('/login', (Request req) async {
      final payload = await req.readAsString();
      final userInfo = json.decode(payload);
      final email = userInfo['email'];
      final password = userInfo['password'];

      // Ensure email and password fields are present
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return Response(HttpStatus.badRequest,
            body: 'Please provide your email and password');
      }

      //final user = await store.findOne(where.eq('email', email));
      final ResultSet resultSet =
          db.select('SELECT *  FROM Users WHERE email = \"' + email + "\"");
      if (resultSet.isEmpty) {
        return Response.forbidden('Incorrect user and/or password');
      }
      print(resultSet.first.toString());
      final user = ({
        'id': resultSet.first['id'],
        '_id': resultSet.first['_id'],
        'email': resultSet.first['email'],
        'password': resultSet.first['password'],
        'salt': resultSet.first['salt']
      });
      // final user = resultSet.toList ();
      print(user.toString());
      final hashedPassword = hashPassword(password, user['salt']);
      if (hashedPassword != user['password']) {
        return Response.forbidden('Incorrect user and/or password');
      }

      // Generate JWT and send with response
      print('User ID:' + user['_id']);
      // final userId = (user['_id'] as ObjectId).toHexString();
      final userId = ObjectId.fromHexString(user['_id']).toString();
      print('User ID:' + userId);
      try {
        final tokenPair = await tokenService.createTokenPair(userId);
        return Response.ok(json.encode(tokenPair.toJson()), headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        });
      } catch (e) {
        return Response.internalServerError(
            body: 'There was a problem logging you in. Please try again.' +
                e.toString());
      }
    });

    router.post('/logout', (Request req) async {
      final auth = req.context['authDetails'];
      if (auth == null) {
        return Response.forbidden('Not authorised to perform this operation.');
      }

      try {
        await tokenService.removeRefreshToken(((auth as JWT)).jwtId.toString());
      } catch (e) {
        return Response.internalServerError(
            body:
                'There was an issue logging out. Please check and try again.');
      }

      return Response.ok('Successfully logged out');
    });

    router.post('/refreshToken', (Request req) async {
      final payload = await req.readAsString();
      final payloadMap = json.decode(payload);

      print(payloadMap['refreshToken'].toString());

      final token = verifyJwt(payloadMap['refreshToken'], secret);
      if (token == null) {
        return Response(400, body: 'Refresh token is not valid.');
      }

      final dbToken =
          await tokenService.getRefreshToken((token as JWT).jwtId.toString());
      if (dbToken == null) {
        return Response(400, body: 'Refresh token is not recognised.');
      }


      // Generate new token pair
      final oldJwt = (token as JWT);
      try {
        await tokenService.removeRefreshToken((token as JWT).jwtId.toString());

        final tokenPair =
            await tokenService.createTokenPair(oldJwt.subject.toString());
        return Response.ok(
          json.encode(tokenPair.toJson()),
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          },
        );
      } catch (e) {
        return Response.internalServerError(
            body:
                'There was a problem creating a new token. Please try again.' + e.toString());
      }
    });

    return router;
  }
}
