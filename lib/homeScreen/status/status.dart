import 'package:flutter/material.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderState extends StatelessWidget {
  final controller = Get.find<MainController>();

  RiderState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor.withOpacity(.2),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'الحالة الحالية',
                    style: GoogleFonts.almarai(fontSize: 16),
                  )),
                  Switch(
                    value: controller.delivery!.deliveryManStatus,
                    activeColor: mainColor,
                    onChanged: (v) => controller.toggleState(),
                  ),
                ],
              ),
              Text(
                controller.delivery!.deliveryManStatus ? 'متوفر' : 'غير متوفر',
                style: GoogleFonts.almarai(
                    fontSize: 20,
                    height: 3,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              Expanded(
                  child: Image(
                image: AssetImage(controller.delivery!.deliveryManStatus
                    ? 'images/working.png'
                    : 'images/sleeping.png'),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
