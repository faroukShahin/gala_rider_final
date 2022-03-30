//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gala_rider/homeScreen/ordersHistory/orderHistoryCard.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class orderHistory extends StatefulWidget {
  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  var now = DateTime.now();
  var formatter = DateFormat.yMMMd('ar_SA');
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatter.format(now),
            textAlign: TextAlign.start,
            style:
                GoogleFonts.almarai(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Obx(() => ListView.separated(
                  itemCount: controller.previousOrders.length,
                  itemBuilder: (context, index) {
                    final order = controller.previousOrders[index];
                    final rest = controller.restaurants
                        .firstWhere((e) => e.id == order.restId);

                    return orderHistoryCard(
                      restaurantModel: rest,
                      orderModel: order,
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
                )),
          )
        ],
      ),
    );
  }

  _changeDate() {}
}
