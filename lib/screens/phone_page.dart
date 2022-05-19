import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellphone/constants.dart';
import 'package:sellphone/models/phones/phones.dart';
import 'package:sellphone/services/hasura.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Телефон"),
      ),
      body: FutureBuilder<Phones>(
          future: Hasura.gerPhonesById(Get.parameters["id"]!),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: snapshot.data!.data!.smartphones![0].image!,
                    fit: BoxFit.cover,
                    width: size.width / 2,
                    height: size.height,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            snapshot.data!.data!.smartphones![0].name!,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Container(
                            width: size.width / 2 - defaultPadding * 2,
                            child: Column(
                              children: [
                                techText("Создан",
                                    "${snapshot.data!.data!.smartphones![0].createDate!}"),
                                Divider(),
                                techText("Процессор",
                                    "${snapshot.data!.data!.smartphones![0].processor!}"),
                                Divider(),
                                techText("Батарея",
                                    "${snapshot.data!.data!.smartphones![0].battery!}"),
                                Divider(),
                                techText("Экран",
                                    "${snapshot.data!.data!.smartphones![0].screen}"),
                                Divider(),
                                techText("Основная камера",
                                    "${snapshot.data!.data!.smartphones![0].mainCamera!}"),
                                Divider(),
                                techText("Фронтальная камера",
                                    "${snapshot.data!.data!.smartphones![0].frontCamera!}"),
                                Divider(),
                                techText("Код устройства",
                                    "${snapshot.data!.data!.smartphones![0].id!}"),
                                Divider(),
                                techText("Цена",
                                    "\$${snapshot.data!.data!.smartphones![0].price!}"),
                                Divider(),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                SizedBox(
                                  width: size.width / 2 - defaultPadding * 2,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed("/buyform", parameters: {
                                          "id": snapshot
                                              .data!.data!.smartphones![0].id!
                                              .toString(),
                                          "price": snapshot.data!.data!
                                              .smartphones![0].price!
                                              .toString()
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            defaultPadding),
                                        child: Text('Купить срочно'),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          }),
    );
  }

  Widget techText(String name, String tech) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(tech),
        ],
      ),
    );
  }
}
