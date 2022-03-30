//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gala_rider/main.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main_controller.dart';
import 'cards.dart';
import 'myWalletCard.dart';

class myWallet extends StatefulWidget{
  @override
  State<myWallet> createState() => _myWalletState();
}

class _myWalletState extends State<myWallet> {
  final controller = Get.find<MainController>();
  double totalEarning=0.0;
  @override
  void initState() {
    super.initState();
    for(int i=0; i<controller.previousOrders.length;i++){
      totalEarning+=controller.previousOrders[i].deliveryCost;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('المحفظة', style: GoogleFonts.almarai(fontSize: 16, color: Colors.black),),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: mainColor
                ),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('رصيدك المتوفر',
                            style: GoogleFonts.almarai(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.start,
                          ),
                          //TODO the total   of paid plus recieved
                          Text('${controller.delivery?.paid??0 - totalEarning} شيكل',
                            style: GoogleFonts.almarai(
                                fontSize: 25,
                                height: 3,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                        radius: 35,
                        backgroundColor: mainColor,
                        child: IconButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>cards()));
                          },
                          icon: const Icon(FontAwesomeIcons.ccVisa,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO the paid money to the app
                        Text('${controller.delivery?.paid??0}+ شيكل',
                          style: GoogleFonts.almarai(
                              fontSize: 25,
                              height: 2,
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text('تم تسليمها',
                          style: GoogleFonts.almarai(
                              fontSize: 16,
                              height: 2,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    ),
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${totalEarning*-1} شيكل',
                          style: GoogleFonts.almarai(
                              fontSize: 25,
                              height: 2,
                              color: Colors.red,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text('تم استلامها',
                          style: GoogleFonts.almarai(
                              fontSize: 16,
                              height: 2,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25,),
                    Text('التعاملات الآخيرة', style: GoogleFonts.almarai(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    const SizedBox(height: 15,),
                    ListView.separated(
                      itemCount: controller.previousOrders.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index){
                        final order = controller.previousOrders[index];
                        final rest = controller.restaurants
                            .firstWhere((e) => e.id == order.restId);
                        return myWalletCard(
                            orderModel: order,
                          restaurantModel: rest,
                        );
                      },
                      separatorBuilder: (context, index){
                        return Container(
                          color: Colors.black45,
                          height: .5,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}