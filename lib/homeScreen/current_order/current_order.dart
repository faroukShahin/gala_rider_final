import 'package:flutter/material.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../currentOrders/receivedOrder.dart';

class current_order extends StatelessWidget {
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => controller.currentOrder == null
              ?  Center(
                  child: Text('لا يوجد طلب حالي قم بقبول طلب ليظهر هنا',
                  style: GoogleFonts.cairo(),),
                )
              : orderReceived(
                  orderModel: controller.currentOrder!,
                  restaurantModel: controller.restaurants.firstWhere(
                      (e) => e.id == controller.currentOrder!.restId),
                  onOrderCompleted: controller.onOrderCompleted,
                  onDeliveryOnWay: controller.onDeliveryOnWay,
                ),
        ),
      ),
    );
  }
}
