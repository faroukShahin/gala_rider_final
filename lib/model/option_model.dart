class OptionModel {
  String nameAr;
  String nameEn;
  double price;

  OptionModel({
    required this.nameAr,
    required this.nameEn,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'price': price,
    };
  }

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      nameAr: map['nameAr'],
      nameEn: map['nameEn'],
      price: double.parse(map['price'].toString()),
    );
  }
}
