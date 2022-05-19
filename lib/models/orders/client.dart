class Client {
  String? adress;
  String? email;
  String? family;
  String? number;

  Client({this.adress, this.email, this.family, this.number});

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        adress: json['adress'] as String?,
        email: json['email'] as String?,
        family: json['family'] as String?,
        number: json['number'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'adress': adress,
        'email': email,
        'family': family,
        'number': number,
      };
}
