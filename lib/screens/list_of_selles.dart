import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sellphone/constants.dart';
import 'package:sellphone/managers/managers/managers.dart';
import 'package:sellphone/models/orders/orders.dart';
import 'package:sellphone/models/sells/sells.dart';
import 'package:sellphone/services/hasura.dart';

class SellesList extends StatefulWidget {
  const SellesList({Key? key}) : super(key: key);

  @override
  State<SellesList> createState() => _SellesListState();
}

class _SellesListState extends State<SellesList> {
  int needUpdate = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.toNamed("/admin"),
            ),
            title: Text("Менеджерство"),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Новые заявки",
                  icon: Icon(Icons.new_label),
                ),
                Tab(
                  text: "Обработанные  заявки",
                  icon: Icon(Icons.folder_open_outlined),
                ),
                Tab(
                  text: "Все менеджеры",
                  icon: Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<Orders>(
                  future: Hasura.getOrders(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: GridView.count(
                            childAspectRatio: (0.618 / 1),
                            crossAxisCount: 3,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            children: List.generate(
                                snapshot.data!.data!.orders!.length, (i) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: InkWell(
                                  onTap: () {},
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
                                              .orders![i].phones![0].image!,
                                          fit: BoxFit.cover,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .orders![i]
                                                        .phones![0]
                                                        .name!,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                      "\$${snapshot.data!.data!.orders![i].phones![0].price}",
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
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Заказал(а): ${snapshot.data!.data!.orders![i].client!.family!}",
                                                  ),
                                                  Text(
                                                    "Почта: ${snapshot.data!.data!.orders![i].client!.email!}",
                                                  ),
                                                  Text(
                                                    "Телефон: ${snapshot.data!.data!.orders![i].client!.number!}",
                                                  ),
                                                  Text(
                                                    "Адрес: ${snapshot.data!.data!.orders![i].client!.adress!}",
                                                  ),
                                                  Text(
                                                    "Доставить до: ${snapshot.data!.data!.orders![i].deadline!}",
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top:
                                                                defaultPadding),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .green)),
                                                          onPressed: () {
                                                            void
                                                                assend() async {
                                                              Hasura.doneTask(
                                                                  await snapshot
                                                                      .data!
                                                                      .data!
                                                                      .orders![
                                                                          i]
                                                                      .id
                                                                      .toString(),
                                                                  GetStorage()
                                                                      .read(
                                                                          "id"),
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .orders![
                                                                          i]
                                                                      .phones![
                                                                          0]
                                                                      .id
                                                                      .toString(),
                                                                  snapshot
                                                                      .data!
                                                                      .data!
                                                                      .orders![
                                                                          i]
                                                                      .summ
                                                                      .toString());
                                                              setState(() {
                                                                needUpdate++;
                                                              });
                                                            }

                                                            assend();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                                'Обработано'),
                                                          )),
                                                    ),
                                                  ),
                                                ],
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
                          ));
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
              FutureBuilder<Sells>(
                  future: Hasura
                      .getSells(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: GridView.count(
                              childAspectRatio: (0.618 / 1),
                              crossAxisCount: 3,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                              children: List.generate(
                                  snapshot.data!.data!.sells!.length, (i) {
                                return ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                            ),
                                            child: Column(children: [
                                              CachedNetworkImage(
                                                height: size.width / 3,
                                                width: double.infinity,
                                                imageUrl: snapshot.data!.data!
                                                    .sells![i].phones!.image!,
                                                fit: BoxFit.cover,
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              defaultPadding),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .sells![i]
                                                                .phones!
                                                                .name!,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                              "\$${snapshot.data!.data!.sells![i].phones!.price}",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets
                                                                .only(
                                                            left:
                                                                defaultPadding,
                                                            right:
                                                                defaultPadding,
                                                            bottom:
                                                                defaultPadding),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Выполил: ${snapshot.data!.data!.sells![i].manager!.name!}",
                                                              ),
                                                              Text(
                                                                "Когда:  ${DateTime.parse(snapshot.data!.data!.sells![i].createdAt!.replaceFirst(RegExp(r'-\d\d:\d\d'), ''))}",
                                                              ),
                                                            ]))
                                                  ])
                                            ]))));
                              })));
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
              SingleChildScrollView(
                child: FutureBuilder<Managers>(
                    future: Hasura.getManagers(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed("/");
                                },
                                child: Text('В Магазин')),
                          ),
                          for (var man in snapshot.data!.data!.managers!)
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text('Имя: ${man.name!}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Фамилия: ${man.family!}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Отчество: ${man.FullName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Почта: ${man.email}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: Icon(
                                        Icons.mail,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Отдел: ${man.otdel!.name!}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      leading: Icon(
                                        Icons.home,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (GetStorage().read("id").toString() ==
                              2.toString())
                            Column(
                              children: [
                                Text("Заявки в менеджеры",
                                    style: TextStyle(fontSize: 32)),
                                for (var man in snapshot.data!.data!.newman!)
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(defaultPadding),
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Text('Имя: ${man.name!}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            leading: Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.blue[500],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Фамилия: ${man.family!}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            leading: Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.blue[500],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Отчество: ${man.FullName}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            leading: Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.blue[500],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text('Почта: ${man.email}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            leading: Icon(
                                              Icons.mail,
                                              color: Colors.blue[500],
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Отдел: ${man.otdel!.name!}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            leading: Icon(
                                              Icons.home,
                                              color: Colors.blue[500],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  void addToManagers() async {
                                                    await Hasura.addToManagers(
                                                        man.id!.toString());
                                                    setState(() {
                                                      needUpdate++;
                                                    });
                                                  }

                                                  addToManagers();
                                                },
                                                child: Text(
                                                    'Добавить в менеджеры')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                Text("Заявок больше нет."),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                              ],
                            )
                        ]);
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
              ),
            ],
          )),
    );
  }
}
