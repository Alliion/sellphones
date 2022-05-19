import 'data.dart';

class Managers {
  ManagerData? data;

  Managers({this.data});

  @override
  String toString() => 'Managers(data: $data)';

  factory Managers.fromJson(Map<String, dynamic> json) => Managers(
        data: json['data'] == null
            ? null
            : ManagerData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}
