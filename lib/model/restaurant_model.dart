class RestaurantModel {
  final String id;

  String nameAr;
  String nameEn;
  String addressAr;
  String addressEn;
  String descriptionAr;
  String descriptionEn;

  String taxesNumber;
  int minimumDeliveryTime;
  int maximumDeliveryTime;
  double latitude;
  double longitude;
  String logo;
  String cover;
  String ownerName;
  String phoneNumber;
  String mail;
  String password;
  bool active;
  double rate;
  double commission;
  double paid;

  bool isBusy;
  bool isOpen;
  List openDate;
  List closeDate;
  int lowestOrderPrice;
  int deliveryPrice;

  RestaurantModel(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.addressAr,
      required this.addressEn,
      required this.descriptionAr,
      required this.descriptionEn,
      required this.taxesNumber,
      required this.minimumDeliveryTime,
      required this.maximumDeliveryTime,
      required this.latitude,
      required this.longitude,
      required this.logo,
      required this.cover,
      required this.ownerName,
      required this.phoneNumber,
      required this.mail,
      required this.password,
      required this.active,
      required this.openDate,
      required this.closeDate,
      required this.deliveryPrice,
      required this.lowestOrderPrice,
      required this.isBusy,
      required this.isOpen,
      required this.commission,
      required this.rate,
      required this.paid});


  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
        id: map['_id'],
        nameAr: map['nameAr'] ?? '',
        nameEn: map['nameEn'] ?? '',
        addressAr: map['addressAr'] ?? '',
        addressEn: map['addressEn'] ?? '',
        descriptionAr: map['descriptionAr'] ?? '',
        descriptionEn: map['descriptionEn'] ?? '',
        taxesNumber: map['taxesNumber'],
        minimumDeliveryTime: map['minimumDeliveryTime'],
        maximumDeliveryTime: map['maximumDeliveryTime'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        logo: map['logo'],
        cover: map['cover'],
        ownerName: map['ownerName'],
        phoneNumber: map['phoneNumber'],
        mail: map['mail'] ?? '',
        password: map['password'] ?? '',
        active: map['active'],
        openDate: map['openDate'],
        closeDate: map['closeDate'],
        deliveryPrice: map['deliveryPrice'],
        isBusy: map['isBusy'],
        isOpen: map['isOpen'],
        lowestOrderPrice: map['lowestOrderPrice'],
        commission: double.tryParse(map['commission'].toString()) ?? 0,
        paid: double.tryParse(map['paid'].toString()) ?? 0,
        rate: double.tryParse(map['rate'].toString()) ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
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
      'mail': mail,
      'password': password,
      'active': active,
      'isBusy': isBusy,
      'isOpen': isOpen,
      'openDate': openDate,
      'closeDate': closeDate,
      'lowestOrderPrice': lowestOrderPrice,
      'deliveryPrice': deliveryPrice,
      'commission': commission,
      'paid': paid,
      'rate': rate,
    };
  }

  RestaurantModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? addressAr,
    String? addressEn,
    String? descriptionAr,
    String? descriptionEn,
    String? taxesNumber,
    int? minimumDeliveryTime,
    int? maximumDeliveryTime,
    double? latitude,
    double? longitude,
    String? logo,
    String? cover,
    String? ownerName,
    String? phoneNumber,
    String? mail,
    String? password,
    bool? active,
    double? rate,
    double? commission,
    double? paid,
    bool? isBusy,
    bool? isOpen,
    List<double>? openDate,
    List<double>? closeDate,
    int? lowestOrderPrice,
    int? deliveryPrice,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      addressAr: addressAr ?? this.addressAr,
      addressEn: addressEn ?? this.addressEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      taxesNumber: taxesNumber ?? this.taxesNumber,
      minimumDeliveryTime: minimumDeliveryTime ?? this.minimumDeliveryTime,
      maximumDeliveryTime: maximumDeliveryTime ?? this.maximumDeliveryTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      logo: logo ?? this.logo,
      cover: cover ?? this.cover,
      ownerName: ownerName ?? this.ownerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      active: active ?? this.active,
      rate: rate ?? this.rate,
      commission: commission ?? this.commission,
      paid: paid ?? this.paid,
      isBusy: isBusy ?? this.isBusy,
      isOpen: isOpen ?? this.isOpen,
      openDate: openDate ?? this.openDate,
      closeDate: closeDate ?? this.closeDate,
      lowestOrderPrice: lowestOrderPrice ?? this.lowestOrderPrice,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
    );
  }
}
