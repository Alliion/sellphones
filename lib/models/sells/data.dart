import 'sell.dart';

class Data {
  List<Sell>? sells;

  Data({this.sells});

  @override
  String toString() => 'Data(sells: $sells)';

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sells: (json['sells'] as List<dynamic>?)
            ?.map((e) => Sell.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'sells': sells?.map((e) => e.toJson()).toList(),
      };
}
