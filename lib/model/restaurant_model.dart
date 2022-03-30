class RestaurantModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String addressAr;
  final String addressEn;
  final String taxesNumber;
  final int minimumDeliveryTime;
  final int maximumDeliveryTime;
  final double latitude;
  final double longitude;
  final String logo;
  final String cover;
  final String ownerName;
  final String phoneNumber;
  final double rate;

  bool isBusy;
  bool isOpen;
  int openDate;
  int closeDate;
  int lowestOrderPrice;
  int deliveryPrice;

  RestaurantModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.addressAr,
    required this.addressEn,
    required this.taxesNumber,
    required this.minimumDeliveryTime,
    required this.maximumDeliveryTime,
    required this.latitude,
    required this.longitude,
    required this.logo,
    required this.cover,
    required this.ownerName,
    required this.phoneNumber,
    required this.openDate,
    required this.closeDate,
    required this.deliveryPrice,
    required this.lowestOrderPrice,
    required this.isBusy,
    required this.isOpen,
    required this.rate,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {

    return RestaurantModel(
      id: map['_id'],
      nameAr: map['nameAr'],
      nameEn: map['nameEn'],
      addressAr: map['addressAr'],
      addressEn: map['addressEn'],
      taxesNumber: map['taxesNumber'],
      minimumDeliveryTime: map['minimumDeliveryTime'],
      maximumDeliveryTime: map['maximumDeliveryTime'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      logo: map['logo'],
      cover: map['cover'],
      ownerName: map['ownerName'],
      phoneNumber: map['phoneNumber'],
      openDate: map['openDate'],
      closeDate: map['closeDate'],
      deliveryPrice: map['deliveryPrice'],
      isBusy: map['isBusy'],
      isOpen: map['isOpen'],
      lowestOrderPrice: map['lowestOrderPrice'],
      rate: double.parse(map['rate'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'addressAr': addressAr,
      'addressEn': addressEn,
      'taxesNumber': taxesNumber,
      'minimumDeliveryTime': minimumDeliveryTime,
      'maximumDeliveryTime': maximumDeliveryTime,
      'latitude': latitude,
      'longitude': longitude,
      'logo': logo,
      'cover': cover,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'isBusy': isBusy,
      'isOpen': isOpen,
      'openDate': openDate,
      'closeDate': closeDate,
      'lowestOrderPrice': lowestOrderPrice,
      'deliveryPrice': deliveryPrice,
      'rate': rate,
    };
  }
}
