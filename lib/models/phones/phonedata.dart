import 'smartphone.dart';

class PhoneData {
  List<Smartphone>? smartphones;

  PhoneData({this.smartphones});

  @override
  String toString() => 'Data(smartphones: $smartphones)';

  factory PhoneData.fromJson(Map<String, dynamic> json) => PhoneData(
        smartphones: (json['smartphones'] as List<dynamic>?)
            ?.map((e) => Smartphone.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'smartphones': smartphones?.map((e) => e.toJson()).toList(),
      };
}
