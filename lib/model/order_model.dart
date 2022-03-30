
import 'CouponModel.dart';
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
  double commission;
  double deliveryCommission;
  final bool paid;

  final String restId;
  final String userId;
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

  double totalCost;
  double couponValue;

  OrderModel(
      {required this.id,
        required this.restId,
        required this.userPhone,
        required this.meals,
        required this.orderTime,
        required this.userName,
        required this.userId,
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
        required this.deliveryId,
        required this.orderNumber,
        required this.deliveryCost,
        this.couponCode,
        this.coupon,
        required this.commission,
        required this.deliveryCommission,
        required this.totalCost,
        this.couponValue = 0});

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
      'commission': commission,
      'deliveryCommission': deliveryCommission,
      'declinedReasons': declinedReasons,
      'deliveryCost': deliveryCost,
      'deliveryId': deliveryId ?? 0,
      'orderNumber': orderNumber,
      'delivery': delivery,
      'couponCode': couponCode ?? '',
      'coupon': coupon?.toMap(),
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
        commission: double.tryParse(map['commission'].toString()) ?? 0,
        deliveryCommission:
        double.tryParse(map['deliveryCommission'].toString()) ?? 0,
        coupon:
        map['coupon'] != null ? CouponModel.fromMap(map['coupon']) : null,
        totalCost: 0);
  }

  static void calcOrderCost(OrderModel order) {
    for (final meal in order.meals) {
      order.totalCost += meal.cost  * meal.number;
    }
    if (order.coupon != null) {
      if (order.coupon!.isPercentage == true) {
        final discountValue = (order.coupon!.value / 100) * order.totalCost;
        final discount = (discountValue <= order.coupon!.biggestDiscount
            ? discountValue
            : order.coupon!.biggestDiscount)
            .toDouble();
        order.totalCost -= discount;
        order.couponValue = discount;
      } else {
        final discountValue = order.totalCost - order.coupon!.value;

        final discount = (discountValue <= order.coupon!.biggestDiscount
            ? discountValue
            : order.coupon!.biggestDiscount)
            .toDouble();
        order.totalCost -= discount;
        order.couponValue = discount;
      }
    }
  }
}
