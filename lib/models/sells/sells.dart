import 'data.dart';

class Sells {
  Data? data;

  Sells({this.data});

  @override
  String toString() => 'Sells(data: $data)';

  factory Sells.fromJson(Map<String, dynamic> json) => Sells(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}
