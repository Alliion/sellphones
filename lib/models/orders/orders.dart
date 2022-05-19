import 'OrdersData.dart';

class Orders {
  OrdersData? data;

  Orders({this.data});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        data: json['data'] == null
            ? null
            : OrdersData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}
