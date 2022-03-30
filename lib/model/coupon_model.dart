class CouponModel {
  final String id;
  final String title;
  final String code;
  final int usage;
  final num largestUsers;
  final String restId;
  final bool isPercentage;
  final num value;
  final DateTime startDate;
  final DateTime endDate;
  final num biggestDiscount;
  final num lessPurchase;
  final bool isActive;

  const CouponModel({
    required this.id,
    required this.title,
    required this.code,
    required this.largestUsers,
    required this.restId,
    required this.isPercentage,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.biggestDiscount,
    required this.lessPurchase,
    required this.isActive,
    required this.usage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'largest_users': largestUsers,
      'rest_id': restId,
      'is_percentage': isPercentage,
      'value': value,
      'start_date': startDate.toUtc().millisecondsSinceEpoch,
      'end_date': endDate.toUtc().millisecondsSinceEpoch,
      'biggest_discount': biggestDiscount,
      'less_purchase': lessPurchase,
      'active': isActive,
      'usage': usage,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
        id: map['_id'],
        title: map['title'],
        usage: map['usage'],
        code: map['code'],
        largestUsers: map['largest_users'],
        restId: map['rest_id'],
        isPercentage: map['is_percentage'],
        value: map['value'],
        startDate:
        DateTime.fromMillisecondsSinceEpoch(map['start_date'], isUtc: true)
            .toLocal(),
        endDate:
        DateTime.fromMillisecondsSinceEpoch(map['end_date'], isUtc: true)
            .toLocal(),
        biggestDiscount: map['biggest_discount'],
        lessPurchase: map['less_purchase'],
        isActive: map['active']);
  }
}
