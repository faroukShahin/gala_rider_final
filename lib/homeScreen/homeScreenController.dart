//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gala_rider/homeScreen/currentOrders/currentOrders.dart';
import 'package:gala_rider/homeScreen/map/map.dart';
import 'package:gala_rider/homeScreen/ordersHistory/ordersHistory.dart';
import 'package:gala_rider/homeScreen/status/status.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:gala_rider/myWallet/myWallet.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'current_order/current_order.dart';

class HomeScreenController extends StatelessWidget {
  final controller = Get.put(MainController());

  HomeScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> bodyList = [
      RiderState(),
      current_order(),
      currentOrders(),
      map(),
      orderHistory(),
    ];

    return Obx(() => controller.delivery == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gala',
                    style: GoogleFonts.almarai(fontSize: 16, color: Colors.black),
                  ),
                  Text(controller.delivery?.name??'',
                    style: GoogleFonts.almarai(fontSize: 16, color: Colors.black),
                  )
                ],
              ),
              actions: [
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => myWallet()));
                    },
                    icon: ImageIcon(
                      AssetImage('images/wallet.png'),
                      color: mainColor,
                    ))
              ],
            ),
            body: SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Obx(() =>
                        Expanded(child: bodyList[controller.index.value])),
                    _bottomNavigation(),
                  ],
                ),
              ),
            ),
          ));
  }

  _bottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(() => Row(
            children: [
              Expanded(
                  child: InkWell(
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.circleNotch,
                        size: 30,
                        color: controller.index.value == 0
                            ? mainColor
                            : Colors.grey),
                    Text(
                      'الحالة',
                      style: TextStyle(
                          height: 2,
                          color: controller.index.value == 0
                              ? mainColor
                              : Colors.grey),
                    )
                  ],
                ),
                onTap: () {
                  controller.index.value = 0;
                },
              )),

              Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.delivery_dining,
                            size: 30,
                            color: controller.index.value == 1
                                ? mainColor
                                : Colors.grey),
                        Text(
                          'الطلب الحالي',
                          style: TextStyle(
                              height: 2,
                              color: controller.index.value == 1
                                  ? mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),

                    onTap: () {
                      controller.index.value = 1;
                    },
                  )),
              Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.sticky_note_2_outlined,
                            size: 30,
                            color: controller.index.value == 2
                                ? mainColor
                                : Colors.grey),
                        Text(
                          'طلبات جاهزة',
                          style: TextStyle(
                              height: 2,
                              color: controller.index.value == 2
                                  ? mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                    onTap: () {
                      controller.index.value = 2;
                    },
                  )),
              Expanded(
                  child: InkWell(
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.map,
                        size: 30,
                        color: controller.index.value == 3
                            ? mainColor
                            : Colors.grey),
                    Text(
                      'الخريطة',
                      style: TextStyle(
                          height: 2,
                          color: controller.index.value == 3
                              ? mainColor
                              : Colors.grey),
                    )
                  ],
                ),
                onTap: () {
                  controller.index.value = 3;
                },
              )),
              Expanded(
                  child: InkWell(
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.clock,
                        size: 30,
                        color: controller.index.value == 4
                            ? mainColor
                            : Colors.grey),
                    Text(
                      'الطلبات السابقة',
                      style: TextStyle(
                          height: 2,
                          color: controller.index.value == 4
                              ? mainColor
                              : Colors.grey),
                    )
                  ],
                ),
                onTap: () {
                  controller.index.value = 4;
                },
              )),
            ],
          )),
    );
  }
}
