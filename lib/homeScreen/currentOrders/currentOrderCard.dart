//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gala_rider/homeScreen/currentOrders/mealCard.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:gala_rider/model/restaurant_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addressCard.dart';

class currentOrderCard extends StatefulWidget {
  final OrderModel orderModel;
  final VoidCallback onAcceptClick;
  final RestaurantModel restaurant;

  const currentOrderCard(
      {Key? key,
      required this.orderModel,
      required this.onAcceptClick,
      required this.restaurant})
      : super(key: key);

  @override
  State<currentOrderCard> createState() => _currentOrderCardState();
}

class _currentOrderCardState extends State<currentOrderCard> {
  bool detailed = false;
  String customer_detailed_address='';
  @override
  void initState() {
    super.initState();
    MainController().getPlace(widget.orderModel.userLatitude, widget.orderModel.userLongitude).then((value){
      setState(() {
        customer_detailed_address=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.sticky_note_2_outlined,
              color: mainColor.withOpacity(.5),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              widget.orderModel.orderNumber.toString(),
              style: const TextStyle(fontSize: 16),
            )),
            Visibility(
              visible: detailed,
              child: InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: mainColor),
                  child: Text(
                    'قبول',
                    style: GoogleFonts.almarai(color: Colors.white),
                  ),
                ),
                onTap: widget.onAcceptClick,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Visibility(
              visible: detailed,
              child: InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: mainColor, width: .5),
                  ),
                  child: Text(
                    'رفض',
                    style: GoogleFonts.almarai(color: mainColor),
                  ),
                ),
                onTap: () {
                  //TODO remove from delivery here
                  setState(() {});
                },
              ),
            ),
            Visibility(
              visible: !detailed,
              child: InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: mainColor),
                  child: Text(
                    'تفاصيل',
                    style: GoogleFonts.almarai(color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    detailed = true;
                  });
                },
              ),
            ),
            Visibility(
              visible: detailed,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      detailed = false;
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_up_rounded)),
            )
          ],
        ),
        Visibility(
          visible: detailed,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.restaurant.nameAr,
                        style: GoogleFonts.almarai(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        widget.restaurant.addressAr,
                        style: GoogleFonts.almarai(fontSize: 12, height: 2),
                        textAlign: TextAlign.start,
                      )
                    ],
                  )),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: mainColor,
                    child: IconButton(
                      onPressed: () {
                        MainController().call_number(widget.restaurant.phoneNumber);
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.black,
                height: .5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 15),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderModel.userName,
                        style: GoogleFonts.almarai(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(customer_detailed_address, style: GoogleFonts.cairo(fontSize: 14, ),),
                    ],
                  )),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: mainColor,
                    child: IconButton(
                      onPressed: () {
                        MainController().call_number(widget.orderModel.userPhone);
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.black,
                height: .5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 15),
              ),
              ListView.builder(
                  itemCount: widget.orderModel.meals.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return mealCard(mealModel: widget.orderModel.meals[index]);
                  }),
              const SizedBox(
                height: 15,
              ),
              addressCard(
                address: widget.orderModel.userAddress!,
                PhoneNumber: widget.orderModel.userPhone,
                lat: widget.orderModel.userLatitude!,
                lng: widget.orderModel.userLongitude!,
              ),
            ],
          ),
        )
      ],
    );
  }

}
