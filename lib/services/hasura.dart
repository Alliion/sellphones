import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hasura_connect/hasura_connect.dart';
import 'package:sellphone/managers/managers/managers.dart';
import 'package:sellphone/models/orders/order.dart';
import 'package:sellphone/models/orders/orders.dart';
import 'package:sellphone/models/phones/phones.dart';
import 'package:sellphone/models/sells/sells.dart';

class Hasura {
  static late HasuraConnect _hasuraConnect;
  static Future<void> init() async {
    String url = 'https://sell-phones-alina-db.herokuapp.com/v1/graphql';
    _hasuraConnect =
        HasuraConnect(url, headers: {"x-hasura-admin-secret": "sashaEdu"});
  }

  static Future<Phones> getPhones(String filter) async {
    String query = """
query MyQuery {
  smartphones(order_by: {name: asc} $filter) {
    battery
    create_date
    front_camera
    image
    main_camera
    name
    processor
    screen
    id
    price
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Phones.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Phones();
    }
  }

  static Future<Phones> getPhonesBatteyDesc(String filter) async {
    String query = """
query MyQuery {
  smartphones(order_by: {battery: desc} $filter)  {
    battery
    create_date
    front_camera
    image
    main_camera
    name
    processor
    screen
    id
    price
  }
}

      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Phones.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Phones();
    }
  }

  static Future<Phones> getPhonesPriceAsc(String filter) async {
    String query = """
query MyQuery {
  smartphones(order_by: {price: asc} $filter) {
    battery
    create_date
    front_camera
    image
    main_camera
    name
    processor
    screen
    id
    price
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Phones.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Phones();
    }
  }

  static Future<Phones> gerPhonesById(String id) async {
    String query = """
query MyQuery {
  smartphones (where: {id: {_eq: $id}}){
    battery
    create_date
    front_camera
    image
    main_camera
    name
    processor
    screen
    id
    price
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Phones.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Phones();
    }
  }

  static Future<bool> getPasswordMyLogin(String email, String datapass) async {
    String query = """
query MyQuery {
  managers(where: {email: {_eq: "$email"}}) {
    password
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      String password = "";
      if (r["data"]["managers"].length != 0) {
        for (var pass in r["data"]["managers"]) {
          password = pass['password'];
        }
      }
      print(password);
      return password == datapass;
    } catch (e) {
      print(e);
      // errorDialog();
      return false;
    }
  }

  static Future<Managers> getManagers() async {
    String query = """
query MyQuery {
  managers(where: {confirmed: {_eq: true}}) {
    id
    Family
    FullName
    Name
    email
    otdel {
      name
    }
  }
  new: managers(where: {confirmed: {_eq: false}}) {
    id
    Family
    FullName
    Name
    email
    otdel {
      name
    }
  }
}

      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Managers.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Managers();
    }
  }

  static Future<String> getManagerId(String email) async {
    String query = """
query MyQuery2 {
  managers(where: {email: {_eq: "$email"}}) {
    id
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return r["data"]["managers"][0]["id"].toString();
    } catch (e) {
      print(e);
      errorDialog();
      return "1";
    }
  }

  static Future<Orders> getOrders() async {
    String query = """
query MyQuery {
  orders {
    client {
      adress
      email
      family
      number
    }
    deadline
    phones {
      id
      image
      name
      price
    }
    summ
    id
  }
}

      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Orders.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Orders();
    }
  }

  static Future<Sells> getSells() async {
    String query = """
query MyQuery2 {
  sells {
    created_at
    id
    sum
    phones {
      image
      price
      name
    }
    manager {
      Name
      Family
      FullName
      email
    }
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.query(query);
      return Sells.fromJson(r);
    } catch (e) {
      print(e);
      errorDialog();
      return Sells();
    }
  }

  static Future<dynamic> createOrder(
      String address,
      String email,
      String family,
      String number,
      String summ,
      String smartohone_id,
      String deadline) async {
    String query = """
mutation MyMutation {
  insert_orders_one(object: {client: {data: {adress: "$address", email: "$email", family: "$family", number: "$number"}}, summ: $summ, smartohone_id: $smartohone_id, deadline: "$deadline"}) {
    id
  }
}

      """;
    try {
      dynamic r = await _hasuraConnect.mutation(query);
    } catch (e) {
      print(e);
      errorDialog();
    }
  }

  static Future<dynamic> insertManager(
    String email,
    String password,
    String otdel,
    String name,
    String FullName,
    String family,
  ) async {
    String query = """
mutation MyMutation {
  insert_managers_one(object: {email: "$email", password: "$password", otdel_id: $otdel, Name: "$name", FullName: "$FullName", Family: "$family"}) {
    id
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.mutation(query);
    } catch (e) {
      print(e);
      errorDialog();
    }
  }

  static Future<dynamic> addToManagers(String id) async {
    String query = """
mutation MyMutation {
  update_managers_by_pk(pk_columns: {id: $id}, _set: {confirmed: true}) {
    id
  }
}
      """;
    try {
      dynamic r = await _hasuraConnect.mutation(query);
    } catch (e) {
      print(e);
      errorDialog();
    }
  }

  static Future<dynamic> doneTask(
    String orderId,
    String managerId,
    String smartphoneId,
    String sum,
  ) async {
    String query = """
mutation MyMutation {
  delete_orders_by_pk(id: $orderId) {
    id
  }
  insert_sells(objects: {manager_id: $managerId, smartphone_id: $smartphoneId, sum: $smartphoneId}) {
    affected_rows
  }
}

      """;
    try {
      dynamic r = await _hasuraConnect.mutation(query);
    } catch (e) {
      print(e);
      errorDialog();
    }
  }

  static void errorDialog() {
    Get.defaultDialog(
      title: "Ошибка",
      middleText: "Ошибка подклюения к серверу.",
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }
}
