import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellphone/models/phones/phones.dart';

import '../constants.dart';
import '../services/hasura.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final radius = 15.0;
  String dropdownValue = 'Все';
  var whatDo = Hasura.getPhones("");
  int needReload = 0;
  String queryFilter = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Магазин"),
            // dont work
            // Obx(() => Text("\$${c.pl.value.money}")),
          ],
        )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: defaultPadding,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.toNamed("/admin");
                          },
                          child: Text('В админку')),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print("You! pressed on this button!");
                            setState(() {
                              whatDo = Hasura.getPhones(queryFilter);
                              dropdownValue = "Все";
                            });
                          },
                          child: Text('Сбросить фильтры')),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Row(
                        children: [
                          Text("Фирма: "),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                if (newValue != 'Все') {
                                  queryFilter =
                                      'where: {firm: {_eq: "$newValue"}}';
                                } else {
                                  queryFilter = '';
                                }

                                whatDo = Hasura.getPhones(queryFilter);
                              });
                            },
                            items: <String>['Все', 'Apple', 'Oneplus', 'Xiaomi']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              whatDo = Hasura.getPhonesPriceAsc(queryFilter);
                              needReload++;
                              print("need sord");
                            });
                          },
                          child: Text('Сортировка по цене')),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              whatDo = Hasura.getPhonesBatteyDesc(queryFilter);
                            });
                          },
                          child: Text('Сортировка по аккумуляторам')),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  FutureBuilder<Phones>(
                      future: whatDo,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.count(
                            shrinkWrap: true,
                            childAspectRatio: (0.618 / 1),
                            crossAxisCount: 3,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            children: List.generate(
                                snapshot.data!.data!.smartphones!.length, (i) {
                              return ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed("/phonepage", parameters: {
                                      "id": snapshot
                                          .data!.data!.smartphones![i].id
                                          .toString()
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                    ),
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: size.width / 3,
                                          width: double.infinity,
                                          imageUrl: snapshot.data!.data!
                                              .smartphones![i].image!,
                                          fit: BoxFit.cover,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  defaultPadding),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.data!
                                                        .smartphones![i].name!,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                      "\$${snapshot.data!.data!.smartphones![i].price!}",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: defaultPadding,
                                                  right: defaultPadding,
                                                  bottom: defaultPadding),
                                              child: Text(
                                                "Технологическое чудо ${snapshot.data!.data!.smartphones![i].name!} c камерой ${snapshot.data!.data!.smartphones![i].mainCamera!} и баттареей на ${snapshot.data!.data!.smartphones![i].battery!},процессор до  ${snapshot.data!.data!.smartphones![i].processor!}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black
                                                        .withOpacity(0.67)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
