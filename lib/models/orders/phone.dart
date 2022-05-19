class Phone {
  int? id;
  String? image;
  String? name;
  int? price;

  Phone({this.id, this.image, this.name, this.price});

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        id: json['id'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'price': price,
      };
}
