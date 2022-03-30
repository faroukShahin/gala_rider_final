//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/order_model.dart';
import '../model/restaurant_model.dart';

class myWalletCard extends StatefulWidget{
  final OrderModel orderModel;
  final RestaurantModel restaurantModel;
  myWalletCard({
    required this.orderModel,
    required this.restaurantModel
  });

  @override
  State<myWalletCard> createState() => _myWalletCardState();
}

class _myWalletCardState extends State<myWalletCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black45
                  )
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(image: NetworkImage(widget.restaurantModel.logo), fit: BoxFit.cover,))),
          const SizedBox(width: 10,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.restaurantModel.nameAr,
                style: GoogleFonts.almarai(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
              Text(widget.restaurantModel.addressAr,
                style: GoogleFonts.almarai(fontSize: 14, height: 2),textAlign: TextAlign.start,)

            ],
          )),
          Text('-${widget.orderModel.deliveryCost}''شيكل', style: GoogleFonts.almarai(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red),)
        ],
      ),
    );
  }
}