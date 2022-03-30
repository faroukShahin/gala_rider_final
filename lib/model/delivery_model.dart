class DeliveryModel {
  final String id;
  String name;
  String phone;
  String identityNumber;
  String mail;
  String password;
  String identityImage;
  String deliveryManImage;
  String deliveryManType;
  String identiyType;
  bool deliveryManStatus;

  double commission;
  double paid;
  double rate;
  double? late;
  double? long;

  DeliveryModel(
      {required this.id,
        required this.name,
        required this.phone,
        required this.identityNumber,
        required this.mail,
        required this.password,
        required this.identityImage,
        required this.deliveryManImage,
        required this.deliveryManType,
        required this.identiyType,
        required this.deliveryManStatus,
        required this.commission,
        required this.paid,
        required this.rate,
        this.late,
        this.long});

  DeliveryModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? identityNumber,
    String? mail,
    String? password,
    String? identityImage,
    String? deliveryManImage,
    String? deliveryManType,
    String? identiyType,
    bool? deliveryManStatus,
    double? late,
    double? long,
    double? commission,
    double? paid,
    double? rate,
  }) {
    return DeliveryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        identityNumber: identityNumber ?? this.identityNumber,
        mail: mail ?? this.mail,
        password: password ?? this.password,
        identityImage: identityImage ?? this.identityImage,
        deliveryManImage: deliveryManImage ?? this.deliveryManImage,
        deliveryManType: deliveryManType ?? this.deliveryManType,
        identiyType: identiyType ?? this.identiyType,
        deliveryManStatus: deliveryManStatus ?? this.deliveryManStatus,
        late: late ?? this.late,
        long: long ?? this.long,
        commission: commission ?? this.commission,
        rate: rate ?? this.rate,
        paid: paid ?? this.paid);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'identityNumber': identityNumber,
      'mail': mail,
      'password': password,
      'identityImage': identityImage,
      'deliveryManImage': deliveryManImage,
      'deliveryManType': deliveryManType,
      'identiyType': identiyType,
      'deliveryManStatus': deliveryManStatus,
      'late': late,
      'long': long,
      'commission': commission,
      'paid': paid,
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      id: map['_id'],
      name: map['name'],
      phone: map['phone'],
      identityNumber: map['identityNumber'],
      mail: map['mail'],
      password: map['password'],
      identityImage: map['identityImage'],
      deliveryManImage: map['deliveryManImage'],
      deliveryManType: map['deliveryManType'],
      identiyType: map['identiyType'],
      deliveryManStatus: map['deliveryManStatus'] as bool,
      late: map['late'] > 0 ? double.tryParse(map['late'].toString()) : 0,
      long: map['long'] > 0 ? double.tryParse(map['long'].toString()) : 0,
      commission: double.tryParse(map['commission'].toString()) ?? 0,
      paid: double.tryParse(map['paid'].toString()) ?? 0,
      rate: double.tryParse(map['rate'].toString()) ?? 0,
    );
  }
}
