import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mitt_arv_movie_app/models/top_movie_model.dart';

class MovieCard extends StatelessWidget {
  final TopRatedMovieModel model;
  const MovieCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          Divider(),
          Text(model.title, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.yellow),textAlign: TextAlign.start,),
          Divider(),
          SizedBox(height: 10.h,),
          (model.image_url != "N/A")? Image.network(model.image_url,
          height: MediaQuery.of(context).size.height*0.4,
          width: MediaQuery.of(context).size.width,
          ) : Image.asset("assets/movie.jpg"),
          SizedBox(height: 10.h,),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Rank"),
                  Text(model.rank.toString()),
                ],
              ),
              Column(
                children: [
                  Text("Rating"),
                  Text(model.rating),
                ],
              ),
              Column(
                children: [
                  Text("Year"),
                  Text(model.year.toString()),
                ],
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}