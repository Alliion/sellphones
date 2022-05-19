import 'otdel.dart';

class New {
  String? family;
  String? FullName;
  String? name;
  String? email;
  Otdel? otdel;
  int? id;

  New({this.family, this.FullName, this.name, this.email, this.otdel, this.id});

  @override
  String toString() {
    return 'New(family: $family, FullName: $FullName, name: $name, email: $email, otdel: $otdel)';
  }

  factory New.fromJson(Map<String, dynamic> json) => New(
      family: json['Family'] as String?,
      FullName: json['FullName'] as String?,
      name: json['Name'] as String?,
      email: json['email'] as String?,
      otdel: json['otdel'] == null
          ? null
          : Otdel.fromJson(json['otdel'] as Map<String, dynamic>),
      id: json['id'] as int?);

  Map<String, dynamic> toJson() => {
        'Family': family,
        'FullName': FullName,
        'Name': name,
        'email': email,
        'otdel': otdel?.toJson(),
      };
}
