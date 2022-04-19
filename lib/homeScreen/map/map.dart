import 'package:flutter/material.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:gala_rider/model/restaurant_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/map_polyline_draw.dart';

import '../../main_controller.dart';

class map extends StatefulWidget {
  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {
  final controller = Get.find<MainController>();
  late RestaurantModel restaurantInfo;

  @override
  void initState() {
    super.initState();
    controller.addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.currentOrder == null
        ? Center(
            child: Text(
              'لا توجد طلبات حالية',
              style: GoogleFonts.cairo(color: Colors.black),
            ),
          )
        : !controller.currentOrder!.inTheWay?
    GoogleMap(
        markers: Set<Marker>.of(controller.mapMarker),
        polylines: Set<Polyline>.of(controller.polylines.values),
        initialCameraPosition: CameraPosition(
          target: LatLng(controller.latitude, controller.longitude),
        )):

    GoogleMap(
        markers: Set<Marker>.of(controller.mapMarker2),
        polylines: Set<Polyline>.of(controller.polylines2.values),
        initialCameraPosition: CameraPosition(
          target: LatLng(controller.latitude, controller.longitude),
        ))
    );
  }
}
