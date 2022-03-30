import 'package:flutter/material.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:gala_rider/model/restaurant_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/map_polyline_draw.dart';

import '../../main_controller.dart';

class map extends StatefulWidget{
  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final controller = Get.find<MainController>();
  late RestaurantModel restaurantInfo;
  @override
  void initState() {
    super.initState();

    restaurantInfo= controller.currentOrder != null?
    controller.restaurants.firstWhere(
            (e) => e.id == controller.currentOrder!.restId)
    :controller.restaurants[0];
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: orderStatus,
      builder: (BuildContext context, value, Widget? child) {
        return controller.currentOrder == null?
        Center(
          child: Text('لا توجد طلبات حالية',
          style: GoogleFonts.cairo(color: Colors.black),),
        )
        :controller.currentOrder!.picking?
        MapPolyLineDraw(
          //These three are compulsory to add otherwise it will generate error
          apiKey: "AIzaSyDiTW5YZ_Tq-BwzOu1HIIAR_qh8yXmJnm8",
          firstPoint: MapPoint(controller.latitude, controller.longitude),
          secondPoint: MapPoint(controller.currentOrder!.userLatitude!, controller.currentOrder!.userLongitude!),
          mapTypes: MapTypes.normal,
          firstPointMarkerIcon: 'images/visba.png',
          secondPointMarkerIcon: 'images/customer.png',
          mapZoom: 15,
          lineColor: mainColor,
        ):
        MapPolyLineDraw(
          //These three are compulsory to add otherwise it will generate error
          apiKey: "AIzaSyDiTW5YZ_Tq-BwzOu1HIIAR_qh8yXmJnm8",
          firstPoint: MapPoint(controller.latitude, controller.longitude),
          secondPoint: MapPoint(restaurantInfo.latitude, restaurantInfo.longitude),
          mapTypes: MapTypes.normal,
          firstPointMarkerIcon: 'images/visba.png',
          secondPointMarkerIcon: 'images/resturaunt.png',
          mapZoom: 15,
          lineColor: mainColor,

        );
      },

    );
  }
}