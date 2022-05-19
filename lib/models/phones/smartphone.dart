class Smartphone {
  String? battery;
  String? createDate;
  String? frontCamera;
  String? image;
  String? mainCamera;
  String? name;
  String? processor;
  String? screen;
  int? id;
  int? price;

  Smartphone({
    this.battery,
    this.createDate,
    this.frontCamera,
    this.image,
    this.mainCamera,
    this.name,
    this.processor,
    this.screen,
    this.id,
    this.price,
  });

  @override
  String toString() {
    return 'Smartphone(battery: $battery, createDate: $createDate, frontCamera: $frontCamera, image: $image, mainCamera: $mainCamera, name: $name, processor: $processor, screen: $screen, id: $id)';
  }

  factory Smartphone.fromJson(Map<String, dynamic> json) => Smartphone(
        battery: json['battery'] as String?,
        createDate: json['create_date'] as String?,
        frontCamera: json['front_camera'] as String?,
        image: json['image'] as String?,
        mainCamera: json['main_camera'] as String?,
        name: json['name'] as String?,
        processor: json['processor'] as String?,
        screen: json['screen'] as String?,
        id: json['id'] as int?,
        price: json['price'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'battery': battery,
        'create_date': createDate,
        'front_camera': frontCamera,
        'image': image,
        'main_camera': mainCamera,
        'name': name,
        'processor': processor,
        'screen': screen,
        'id': id,
      };
}
