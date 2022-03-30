//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';
import '../../main_controller.dart';

class addressCard extends StatefulWidget{
  String  address,PhoneNumber;
  double lat, lng;
  addressCard({
    required this.address,
    required this.PhoneNumber,
    required this.lat,
    required this.lng
  });

  @override
  State<addressCard> createState() => _addressCardState();
}

class _addressCardState extends State<addressCard> {
  String detailed_address='الموقع';
  @override
  void initState() {
    super.initState();
    MainController().getPlace(widget.lat, widget.lng).then((value) {
      setState(() {
        detailed_address=value;
      });
    }).onError((error, stackTrace){
      setState(() {
        detailed_address='حدث خطأ اثناء تحديد الموقع ';
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller)=>Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black45)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: 150,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat, widget.lng),
                      zoom: 12
                  ),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      const SizedBox(width: 5,),
                      Text(widget.address, style:  GoogleFonts.cairo(fontWeight: FontWeight.w400, fontSize: 16),textAlign: TextAlign.right,),
                      Expanded(child: Container()),
                    ],
                  ),
                  Text(detailed_address, style:  GoogleFonts.cairo(color: Colors.black45),textAlign: TextAlign.right),
                  Text('رقم الهاتف:  ' '${widget.PhoneNumber}', style: GoogleFonts.cairo(color: Colors.black45, height: 2),textAlign: TextAlign.right),

                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }


}