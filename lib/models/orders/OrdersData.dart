import 'order.dart';

class OrdersData {
  List<Order>? orders;

  OrdersData({this.orders});

  factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'orders': orders?.map((e) => e.toJson()).toList(),
      };
}
