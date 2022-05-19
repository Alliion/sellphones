class Phones {
  String? image;
  int? price;
  String? name;

  Phones({this.image, this.price, this.name});

  @override
  String toString() => 'Phones(image: $image, price: $price, name: $name)';

  factory Phones.fromJson(Map<String, dynamic> json) => Phones(
        image: json['image'] as String?,
        price: json['price'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'price': price,
        'name': name,
      };
}
