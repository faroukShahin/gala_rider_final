import 'model/order_model.dart';

double getCouponValue(OrderModel order){
  double total = 0;
  for (final meal in order.meals) {
    total += meal.cost;
  }
  if(order.coupon!=null){
    if(order.coupon!.isPercentage){
      double discount = ((order.coupon!.value)/100)*total;
      if(order.coupon!.biggestDiscount>discount){
        return discount;
      }
    }else{
      return order.coupon!.biggestDiscount.toDouble();
    }
  }
  return 0;
}
double getMealsCost(OrderModel order){
  double total = 0;
  for (final meal in order.meals) {
    total += meal.cost;
  }
  return total;
}
double getOrderTotalCost(OrderModel order) {
  double total = 0;
  for (final meal in order.meals) {
    total += meal.cost;
  }
  if(order.coupon!=null){
    if(order.coupon!.isPercentage){
      double discount = ((order.coupon!.value)/100)*total;
      if(order.coupon!.biggestDiscount>discount){
        return total - discount;
      }
    }else{
      return total - order.coupon!.biggestDiscount;
    }
  }
  return total;
}