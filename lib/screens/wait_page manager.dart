import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellphone/constants.dart';

class WaitManager extends StatelessWidget {
  const WaitManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Ожидайте, пока вас добавят в админы",
                style: TextStyle(fontSize: 24)),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed("/admin");
              },
              child: Text('Временная кнопочка для админа')),
        ],
      ),
    );
  }
}
