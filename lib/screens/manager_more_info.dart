import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellphone/services/hasura.dart';

import '../constants.dart';

class MoreInfo extends StatefulWidget {
  final String email;
  final String password;
  final String id;
  const MoreInfo({
    Key? key,
    required this.email,
    required this.password,
    required this.id,
  }) : super(key: key);

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  String? famName;
  String? FullName;
  String? otdel;
  String dropdownValue = "Продажи";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Нам нужно больше информации",
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
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              padding: EdgeInsets.all(defaultPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Имя',
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
                          labelText: 'Фамилия',
                        ),
                        onSaved: (String? value) {
                          famName = value;
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
                          labelText: 'Отчество',
                        ),
                        onSaved: (String? value) {
                          FullName = value;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Пусто';
                          }
                          return null;
                        }),
                    Row(
                      children: [
                        Text("Отдел: "),
                        SizedBox(
                          width: 150,
                          child: DropdownButton<String>(
                            hint: Text("Отдел"),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Продажи', 'Администрация']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Hasura.insertManager(
                                  widget.email,
                                  widget.password,
                                  dropdownValue == "Продажи"
                                      ? 3.toString()
                                      : 5.toString(),
                                  name!,
                                  FullName!,
                                  famName!);
                              Get.toNamed("/waitManager",
                                  parameters: {"id": widget.id});
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Text('Зарегистрироваться как менеджер'),
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
