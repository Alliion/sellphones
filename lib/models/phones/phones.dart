import 'phonedata.dart';

class Phones {
  PhoneData? data;

  Phones({this.data});

  @override
  String toString() => 'Phones(data: $data)';

  factory Phones.fromJson(Map<String, dynamic> json) => Phones(
        data: json['data'] == null
            ? null
            : PhoneData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}
