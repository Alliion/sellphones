import 'client.dart';
import 'phone.dart';

class Order {
  Client? client;
  String? deadline;
  List<Phone>? phones;
  int? summ;
  int? id;

  Order({this.client, this.deadline, this.phones, this.summ, this.id});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        client: json['client'] == null
            ? null
            : Client.fromJson(json['client'] as Map<String, dynamic>),
        deadline: json['deadline'] as String?,
        phones: (json['phones'] as List<dynamic>?)
            ?.map((e) => Phone.fromJson(e as Map<String, dynamic>))
            .toList(),
        summ: json['summ'] as int?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'client': client?.toJson(),
        'deadline': deadline,
        'phones': phones?.map((e) => e.toJson()).toList(),
        'summ': summ,
        'id': id,
      };
}
