
import 'option_model.dart';

class MealModel {
  String mealNameAr;
  String mealNameEn;
  String mealDescriptionAr;
  String mealDescriptionEn;
  String mealImage;
  double cost;
  int number;
  String mealId;
  String note;

  /// offer
  bool? isOffer;
  bool? isPercentageOffer;
  double? offerValue;
  DateTime? startOfferDate;
  DateTime? endOfferDate;

  OptionModel? option;

  MealModel(
      {required this.mealNameAr,
        required this.mealNameEn,
        required this.mealDescriptionAr,
        required this.mealDescriptionEn,
        required this.mealImage,
        required this.cost,
        required this.number,
        required this.mealId,
        required this.note,
        this.offerValue,
        this.isOffer,
        this.isPercentageOffer,
        this.startOfferDate,
        this.option,
        this.endOfferDate});

  Map<String, dynamic> toMap() {

    return {
      'mealNameAr': mealNameAr,
      'mealNameEn': mealNameEn,
      'mealDescriptionAr': mealDescriptionAr,
      'mealDescriptionEn': mealDescriptionEn,
      'mealImage': mealImage,
      'cost': cost,
      'number': number,
      'mealId': mealId,
      'note': note,
      'option': option?.toMap()
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    print(map);

    return MealModel(
        mealNameAr: map['mealNameAr'] ?? '',
        mealNameEn: map['mealNameEn'] ?? '',
        mealDescriptionAr: map['mealDescriptionAr'] ?? '',
        mealDescriptionEn: map['mealDescriptionEn'] ?? '',
        mealImage: map['mealImage'],
        cost: double.parse(map['cost'].toString()),
        number: map['number'],
        mealId: map['mealId'],
        note: map['note'] ?? '',
        option: map['option'] != null ? OptionModel.fromMap(map['option']) : null
    );
  }
}
