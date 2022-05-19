import 'manager.dart';
import 'new.dart';

class ManagerData {
  List<Manager>? managers;
  List<New>? newman;

  ManagerData({this.managers, this.newman});

  @override
  String toString() => 'Data(managers: $managers, new: $newman)';

  factory ManagerData.fromJson(Map<String, dynamic> json) => ManagerData(
        managers: (json['managers'] as List<dynamic>?)
            ?.map((e) => Manager.fromJson(e as Map<String, dynamic>))
            .toList(),
        newman: (json['new'] as List<dynamic>?)
            ?.map((e) => New.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'managers': managers?.map((e) => e.toJson()).toList(),
        'new': newman?.map((e) => e.toJson()).toList(),
      };
}
