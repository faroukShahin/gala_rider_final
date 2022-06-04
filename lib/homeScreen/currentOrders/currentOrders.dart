//ignore_for_file: file_names
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gala_rider/homeScreen/currentOrders/currentOrderCard.dart';
import 'package:gala_rider/homeScreen/currentOrders/orderDelivered.dart';
import 'package:gala_rider/homeScreen/currentOrders/receivedOrder.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class currentOrders extends StatelessWidget {
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'طلبات جديدة',
            textAlign: TextAlign.start,
            style:
                GoogleFonts.almarai(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: orderStatus,
              builder: (BuildContext context, value, Widget? child) {
                return Obx(() {
                  final orders = controller.orders
                      .where((element) =>
                          calculateDistance(
                              controller.latitude,
                              controller.longitude,
                              element.userLatitude,
                              element.userLongitude) <
                          2000)
                      .toList();
                  return ListView.separated(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      return currentOrderCard(
                        orderModel: order,
                        onAcceptClick: () => _showAcceptOrderDialog(order),
                        restaurant: controller.restaurants
                            .firstWhere((e) => e.id == order.restId),
                        onReject: () => controller.onRejectOrder(order),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.black,
                        height: .5,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                      );
                    },
                  );
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAcceptOrderDialog(OrderModel orderModel) {
    Get.defaultDialog(
      title: 'تأكيد',
      middleText:
          'هل أنت متأكد من أنك تريد قبول الطلب رقم ${orderModel.orderNumber}',
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.white,
      onCancel: Get.back,
      onConfirm: () {
        Get.back();
        controller.acceptOrder(orderModel);
      },
    );
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
