import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal"),
        actions: [
          IconButton(onPressed: (){
            print("favourite button clicked");
          }, icon: Icon(Icons.favorite, color: Colors.red,),),
          SizedBox(width: 10.w,),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Animal", style: TextStyle(fontSize: 38.sp),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("2024"),
                  SizedBox(width: 15.w,),
                  Text("PG"),
                  SizedBox(width: 15.w,),
                  Text("1h 41m"),
              ],),
              SizedBox(height: 10.h,),
              Image.network("https://m.media-amazon.com/images/I/61OmlO9stnL._SX300_SY300_QL70_FMwebp_.jpg"),
              SizedBox(height: 20.h,),
              Divider(),
              SizedBox(
                // height: MediaQuery.of(context).size.height*0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.star, color: Colors.yellow,),
                    Text("7.0/10"),
                    Text("131106", style: TextStyle(fontSize: 12.sp, color: Colors.grey),),
                      ],
                    ),
                    Column(children: [
                      Icon(Icons.people_outline_sharp),
                      Text("165.789"),
                    ],),

                    Column(children: [
                      Icon(Icons.video_library_outlined),
                      Text("263876"),
                    ],),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Description: ", style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),),
                ],
              ),
              Text("Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."),
            ],
          ),
        ),
      ),
    );
  }
}