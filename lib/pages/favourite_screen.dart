import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mitt_arv_movie_app/constants/movie_card.dart';
import 'package:mitt_arv_movie_app/pages/movie_details_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Favourites"),
          Icon(Icons.favorite, color: Colors.red,)
        ],
      ), centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(15.w),child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MovieDetailsScreen();
            },));
          },
          child: MovieCard());
      },),
    ) );
  }
}