import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sellphone/screens/manager_more_info.dart';
import 'package:sellphone/services/hasura.dart';

class loginController extends GetxController {
  Duration get _loginTime => Duration(milliseconds: 0);
  late String _email;
  late String _password;
  bool _registry = false;
  bool isStudent = false;
  String id = "1";

  Future<String?> authUser(LoginData data) async {
    var password = await Hasura.getPasswordMyLogin(data.name, data.password);

    if (password) {
      id = await Hasura.getManagerId(data.name);
      GetStorage().write("id", id);
      _registry = true;
      return Future.delayed(_loginTime).then((_) {
        return null;
      });
    }
    return "Пароль не верен";
  }

  Future<String?> recoverPassword(String name) {
    return Future.delayed(_loginTime).then((_) {
      return "Error";
    });
  }

  Future<String?> registry(LoginData data) {
    _registry = true;
    _email = data.name.toLowerCase();
    _password = data.password;
    Get.to(() => MoreInfo(
          password: _password,
          email: _email,
          id: id,
        ));
    return Future.delayed(_loginTime).then((_) {
      return null;
    });
  }

  void onComplete() {
    if (_registry) {
      Get.toNamed("/SellesList", parameters: {"id": id});
    }
  }
}
