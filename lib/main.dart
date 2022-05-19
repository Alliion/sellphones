import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sellphone/screens/form.dart';
import 'package:sellphone/screens/list_of_selles.dart';
import 'package:sellphone/screens/login.dart';
import 'package:sellphone/screens/phone_page.dart';

import 'screens/home.dart';
import 'screens/wait_page manager.dart';
import 'screens/wait_page.dart';
import 'services/hasura.dart';

void main() async {
  //init services
  await Hasura.init();
  await GetStorage.init();
  // check reg

  runApp(GetMaterialApp(
    title: "sellphone",
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.light,
    getPages: [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/phonepage', page: () => PhonePage()),
      GetPage(name: '/buyform', page: () => BuyForm()),
      GetPage(name: '/waitSell', page: () => WaitSell()),
      GetPage(name: '/admin', page: () => LoginForm()),
      GetPage(name: '/SellesList', page: () => SellesList()),
      GetPage(name: '/waitManager', page: () => WaitManager()),
    ],
  ));
}
