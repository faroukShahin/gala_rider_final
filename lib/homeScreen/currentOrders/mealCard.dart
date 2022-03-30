//ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gala_rider/model/meal_model.dart';
import 'package:google_fonts/google_fonts.dart';

class mealCard extends StatelessWidget{

  final MealModel mealModel;

  const mealCard({Key? key,required this.mealModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image(image: NetworkImage(mealModel.mealImage), fit: BoxFit.cover,),
          ),
        ),
          const SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mealModel.mealNameAr, style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),),
              Text(mealModel.mealDescriptionAr, style: GoogleFonts.almarai(fontSize: 14, fontWeight: FontWeight.w300, height: 1.5),),
            ],
          ), ),
          Text(mealModel.number.toString()+' x ', style: const TextStyle(color: Colors.grey),)
        ],
      ),
    );
  }

}