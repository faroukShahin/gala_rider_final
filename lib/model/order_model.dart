

import 'coupon_model.dart';
import 'meal_model.dart';

class OrderModel {
  final String id;
  bool accepted;
  bool cooked;
  bool picking;
  bool inTheWay;
  bool completed;
  bool declined;
  String? declinedReasons;

  final bool paid;

  final String restId;
  String? userId;
  final String userName;
  final String userPhone;
  final List<MealModel> meals;
  final DateTime orderTime;

  final String? userAddress;
  final double? userLatitude;
  final double? userLongitude;

  String? deliveryId;
  final int orderNumber;
  final bool delivery;

  final double deliveryCost;

  final String? couponCode;
  final CouponModel? coupon;

  String restNameAr;
  String restNameEn;
  String restCover;
  int deliveryTime;

  OrderModel({
    required this.id,
    required this.restId,
    required this.userPhone,
    required this.meals,
    required this.orderTime,
    required this.userName,
    this.userId,
    this.userAddress,
    this.userLatitude,
    this.userLongitude,
    this.accepted = false,
    this.cooked = false,
    this.picking = false,
    this.inTheWay = false,
    this.completed = false,
    this.paid = false,
    this.declined = false,
    this.declinedReasons,
    required this.delivery,
    this.deliveryId,
    required this.orderNumber,
    required this.deliveryCost,
    required this.restNameAr,
    required this.restNameEn,
    required this.restCover,
    required this.deliveryTime,
    this.couponCode,
    this.coupon,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'restId': restId,
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'userAddress': userAddress ?? '',
      'userLatitude': userLatitude ?? 0,
      'userLongitude': userLongitude ?? 0,
      'meals': meals.map((e) => e.toMap()).toList(),
      'orderTime': orderTime.toUtc().millisecondsSinceEpoch,
      'accepted': accepted,
      'cooked': cooked,
      'picking': picking,
      'inTheWay': inTheWay,
      'completed': completed,
      'paid': paid,
      'declined': declined,
      'declinedReasons': declinedReasons,
      'deliveryCost': deliveryCost,
      'deliveryId': deliveryId ?? 0,
      'orderNumber': orderNumber,
      'delivery': delivery,
      'couponCode': couponCode ?? '',
      'restNameAr': restNameAr,
      'restNameEn': restNameEn,
      'restCover': restCover,
      'deliveryTime': deliveryTime,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {

    return OrderModel(
      id: map['_id'],
      userName: map['userName'],
      restId: map['restId'],
      userId: map['userId'],
      userPhone: map['userPhone'],
      userAddress: map['userAddress'],
      userLatitude: double.parse(map['userLatitude'].toString()),
      userLongitude: double.parse(map['userLongitude'].toString()),
      meals: (map['meals'] as List).map((e) => MealModel.fromMap(e)).toList(),
      orderTime:
      DateTime.fromMillisecondsSinceEpoch(map['orderTime'], isUtc: true)
          .toLocal(),
      accepted: map['accepted'],
      cooked: map['cooked'],
      picking: map['picking'],
      inTheWay: map['inTheWay'],
      completed: map['completed'],
      paid: map['paid'],
      declined: map['declined'],
      declinedReasons: map['declinedReasons'],
      deliveryCost: double.parse(map['deliveryCost'].toString()),
      deliveryId: map['deliveryId'],
      orderNumber: map['orderNumber'],
      delivery: map['delivery'],
      couponCode: map['couponCode'],
      coupon: map['coupon'] != null ? CouponModel.fromMap(map['coupon']) : null,
      restNameAr: map['restNameAr'],
      restNameEn: map['restNameEn'],
      restCover: map['restCover'],
      deliveryTime: map['deliveryTime'],
    );
  }
}
