//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import 'addressCard.dart';
import 'mealCard.dart';

class orderDelivered extends StatefulWidget{
  @override
  State<orderDelivered> createState() => _orderDeliveredState();
}

class _orderDeliveredState extends State<orderDelivered> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Icon(Icons.sticky_note_2_outlined, color: mainColor.withOpacity(.5),),
            const SizedBox(width: 10,),
            const Expanded(child: Text('65140122', style: TextStyle(fontSize: 16),)),

            InkWell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: mainColor
                ),
                child: Text('تم التسليم', style: GoogleFonts.almarai(color: Colors.white),),
              ),
              onTap: (){
                setState(() {
                  orderStatus.value=0;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Icon(Icons.person, size: 40,color: mainColor.withOpacity(.5)),
                const SizedBox(width: 15,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('محمد السعيد', style: GoogleFonts.almarai(fontSize: 14, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    RichText(text: TextSpan(
                        children: [
                          TextSpan(text:'الشارع: شارع صلاح الدين\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                          TextSpan(text:'المنطقة: محطة الشوا للبترول\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                          TextSpan(text:'مدينة: رام الله\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                          TextSpan(text:'نوع المبني: شقة\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                          TextSpan(text:'اسم أو رقم البناية: ٨١\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                          TextSpan(text:'الدور: الثاني\n', style: GoogleFonts.almarai(fontSize: 12, height: 1.5, color: Colors.grey) ),
                        ]
                    ))
                  ],
                )),
                Text('12.00 شيكل', style: GoogleFonts.almarai(color: Colors.grey),),
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
                 Icon(Icons.restaurant_menu, size: 40,color: mainColor.withOpacity(.5)),
                const SizedBox(width: 15,),
                Expanded(child:Text('65140112', style: GoogleFonts.almarai(fontSize: 18, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                ),
                Text('الدفع عند التسليم', style: GoogleFonts.almarai(color: Colors.red, fontSize: 16),)
              ],
            ),
            Container(
              color: Colors.black,
              height: .5,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 15),
            ),
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index){

                  return Container();
                  // return mealCard();
                }),
            const SizedBox(height: 15,),
            //TODO maps
            addressCard(
              address: 'المسجد العمري الكبير',
              lat: 30,
              lng: 30,
              PhoneNumber: '972599998837+'
              ,

            ),
          ],
        ),



      ],
    );

  }
}