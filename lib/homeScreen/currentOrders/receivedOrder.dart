//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gala_rider/homeScreen/currentOrders/mealCard.dart';
import 'package:gala_rider/main.dart';
import 'package:gala_rider/main_controller.dart';
import 'package:gala_rider/model/order_model.dart';
import 'package:gala_rider/model/restaurant_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addressCard.dart';

class orderReceived extends StatefulWidget {
  final OrderModel orderModel;
  final RestaurantModel restaurantModel;

  final VoidCallback? onDeliveryOnWay;
  final VoidCallback? onOrderCompleted;

  const orderReceived(
      {Key? key,
      required this.orderModel,
      required this.restaurantModel,
      this.onOrderCompleted,
      this.onDeliveryOnWay})
      : super(key: key);

  @override
  State<orderReceived> createState() => _orderReceivedState();
}

class _orderReceivedState extends State<orderReceived> {
  String customer_detailed_address='';
  num total_cost=0;
  @override
  void initState() {
    super.initState();
    MainController().getPlace(widget.orderModel.userLatitude, widget.orderModel.userLongitude).then((value){
      setState(() {
        customer_detailed_address=value;
      });
    });
    for(int i=0; i<widget.orderModel.meals.length;i++){
      setState(() {
        total_cost=total_cost=widget.orderModel.meals[i].cost+total_cost;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            widget.orderModel.completed
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainColor),
                    child: Text(
                      'الطلب مكتمل',
                      style: GoogleFonts.almarai(color: Colors.white),
                    ),
                  )
                : widget.orderModel.inTheWay
                    ? InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: mainColor),
                          child: Text(
                            'تم التسليم',
                            style: GoogleFonts.almarai(color: Colors.white),
                          ),
                        ),
                        onTap: widget.onOrderCompleted,
                      )
                    : InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: mainColor),
                          child: Text(
                            'تم الاستلام من المطعم',
                            style: GoogleFonts.almarai(color: Colors.white),
                          ),
                        ),
                        onTap: widget.onDeliveryOnWay,
                      )
          ],
        ),
        Column(
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
                      widget.restaurantModel.nameAr,
                      style: GoogleFonts.almarai(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      widget.restaurantModel.addressAr,
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
                      MainController().call_number(widget.restaurantModel.phoneNumber);
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
                    Text(customer_detailed_address, style: GoogleFonts.cairo(fontSize: 14),)
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
            Row(
              children: [
                const Icon(Icons.restaurant_menu,
                    size: 40, color: Colors.black),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    widget.orderModel.userPhone,
                    style: GoogleFonts.almarai(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  '${total_cost} شيكل',
                  style: GoogleFonts.almarai(color: Colors.grey),
                ),
                Text(
                  ' الدفع عند التسليم',
                  style: GoogleFonts.almarai(color: Colors.red, fontSize: 16),
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
                  //return mealCard();
                }),
            const SizedBox(
              height: 15,
            ),
            //TODO maps
            widget.orderModel.picking?
            addressCard(
              address: widget.orderModel.userAddress!,
              PhoneNumber: widget.orderModel.userPhone,
              lat: widget.orderModel.userLatitude!,
              lng: widget.orderModel.userLongitude!,
            ):addressCard(
              address: widget.restaurantModel.addressAr,
              PhoneNumber: widget.restaurantModel.nameAr,
              lat: widget.restaurantModel.latitude,
              lng: widget.restaurantModel.longitude,
            ),
          ],
        ),
      ],
    );
  }
}
