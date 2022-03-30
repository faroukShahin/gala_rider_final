//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cardsCard extends StatelessWidget{
  String cardNumber='2365123456321132';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const SizedBox(
            height: 30,
            child: Image(image: AssetImage('images/cards.png'),color: Colors.blueAccent,),
          ),
          const SizedBox(width: 10,),
          Expanded(child: Text(cardNumber.replaceRange(5, cardNumber.length, ' **** **** ****'))),
          TextButton(
              onPressed: (){
                _removeCard(context);
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red),))

        ],
      ),
    );
  }
  _removeCard(context){
    showDialog(
        context: context,
        builder: (context){
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('حذف البطاقة', style: GoogleFonts.almarai(),),
              content: Text('هل أنت متأكد أنك تريد حذف البطاقة؟', style: GoogleFonts.almarai(fontSize: 14),),
              actions: [
                TextButton(
                    onPressed: (){
                    },
                    child: const Text('نعم', style: TextStyle(color: Colors.red),)),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);

                    },
                    child: const Text('لا', style: TextStyle(color: Colors.red),))

              ],
            ),
          );
        });
  }
}