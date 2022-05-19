import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sellphone/constants.dart';
import 'package:sellphone/services/hasura.dart';

class BuyForm extends StatefulWidget {
  const BuyForm({Key? key}) : super(key: key);

  @override
  State<BuyForm> createState() => _BuyFormState();
}

class _BuyFormState extends State<BuyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  String? name;
  String? phone;
  String? email;
  String? adress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Покупка"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Чтобы продолжить покупку, укажите данные",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  padding: EdgeInsets.all(defaultPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Составление заказа"),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Ваше имя',
                          ),
                          onSaved: (String? value) {
                            name = value;
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Пусто';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'телефон',
                            ),
                            onSaved: (String? value) {
                              phone = value;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Пусто';
                              }
                              return null;
                            }),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Адрес',
                            ),
                            onSaved: (String? value) {
                              adress = value;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Пусто';
                              }
                              return null;
                            }),
                        TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Почта',
                            ),
                            onSaved: (String? value) {
                              email = value;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Пусто';
                              }
                              return null;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Доставить до:"),
                              TextButton(
                                onPressed: () => _selectDate(context),
                                child: Text(DateFormat.yMMMd()
                                    .format(currentDate)
                                    .toString()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Process data.
                                  _formKey.currentState!.save();
                                  Hasura.createOrder(
                                      adress!,
                                      email!,
                                      name!,
                                      phone!,
                                      Get.parameters["price"]!,
                                      Get.parameters["id"]!,
                                      DateFormat.yMMMd()
                                          .format(currentDate)
                                          .toString());
                                  Get.toNamed("/waitSell");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Text('Купить'),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
