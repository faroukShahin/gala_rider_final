import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addCard.dart';
import 'cardsCard.dart';

class cards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return addCard();
                });
          },
          child: const Text('إضافة', style: TextStyle(color: Colors.blue),),
        ),
        centerTitle: true,
        title: Text('بطاقاتك', style: GoogleFonts.almarai(color: Colors.black, fontSize: 16),),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.black,))
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: .5,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black45
                ),
              );
            },
            itemBuilder: (context, index){
              return cardsCard();
            },
          ),
        ),
      ),
    );
  }

}