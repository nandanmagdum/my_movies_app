import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width,),
        Image.network("https://m.media-amazon.com/images/I/61OmlO9stnL._SX300_SY300_QL70_FMwebp_.jpg",
        height: MediaQuery.of(context).size.height*0.4,
        width: MediaQuery.of(context).size.width,
        ),
      SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Animal", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Text("8.9"),
                SizedBox(width: 10.w,),
                Text("89%"),
                SizedBox(width: 10.w,),
                Text("2024"),
              ],
            ),
          ],
        ),
      ),
      ],
    );
  }
}