class Otdel {
  String? name;

  Otdel({this.name});

  @override
  String toString() => 'Otdel(name: $name)';

  factory Otdel.fromJson(Map<String, dynamic> json) => Otdel(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
