class Manager {
  String? name;
  String? family;
  String? FullName;
  String? email;

  Manager({this.name, this.family, this.FullName, this.email});

  @override
  String toString() {
    return 'Manager(name: $name, family: $family, FullName: $FullName, email: $email)';
  }

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        name: json['Name'] as String?,
        family: json['Family'] as String?,
        FullName: json['FullName'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Family': family,
        'FullName': FullName,
        'email': email,
      };
}
