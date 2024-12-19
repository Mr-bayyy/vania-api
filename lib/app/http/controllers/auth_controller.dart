import 'package:vania_api/app/models/user.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {

  Future<Response> login(Request request) async {

    var user = await User().query().where('email', '=', request.input('email')).first();
    if (user == null) {
      return Response.json({
        "message": "Data user tidak terdaftar",
      }, 409);
    }

    if (request.input('password').toString() !=  user['password']) {
      return Response.json({
        "message": "Password salah!",
      }, 401);
    }

    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 15), withRefreshToken: true);

    return Response.json({
      "message": "login berhasil!",
      "token": token,
    });
  }
}

final AuthController authController = AuthController();
