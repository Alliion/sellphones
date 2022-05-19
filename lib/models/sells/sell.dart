import 'manager.dart';
import 'phones.dart';

class Sell {
  String? createdAt;
  String? id;
  int? sum;
  Phones? phones;
  Manager? manager;

  Sell({this.createdAt, this.id, this.sum, this.phones, this.manager});

  @override
  String toString() {
    return 'Sell(createdAt: $createdAt, id: $id, sum: $sum, phones: $phones, manager: $manager)';
  }

  factory Sell.fromJson(Map<String, dynamic> json) => Sell(
        createdAt: json['created_at'] as String?,
        id: json['id'] as String?,
        sum: json['sum'] as int?,
        phones: json['phones'] == null
            ? null
            : Phones.fromJson(json['phones'] as Map<String, dynamic>),
        manager: json['manager'] == null
            ? null
            : Manager.fromJson(json['manager'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'id': id,
        'sum': sum,
        'phones': phones?.toJson(),
        'manager': manager?.toJson(),
      };
}
