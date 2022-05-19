import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:sellphone/controllers/login_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loginController c = Get.put(loginController());

  String? name;
  String? phone;
  String? email;
  String? adress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLogin(
      title: "Админка менеджеров Алины",
      onLogin: c.authUser,
      onSignup: c.registry,
      onSubmitAnimationCompleted: c.onComplete,
      messages: LoginMessages(
        userHint: 'почта',
        passwordHint: 'пароль',
        confirmPasswordHint: 'подтвердить',
        loginButton: 'ВОЙТИ',
        signupButton: 'Зарегистрироваться',
        forgotPasswordButton: 'забыл пароль?',
        recoverPasswordButton: 'ПОМОЩЬ',
        goBackButton: 'НАЗАД',
        confirmPasswordError: 'Не подходит!',
        recoverPasswordDescription: 'ты слишком много меня тестируешь',
        recoverPasswordSuccess: 'ошибка',
      ),
      onRecoverPassword: c.recoverPassword,
    ));
  }
}
