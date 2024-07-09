import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mitt_arv_movie_app/constants/movie_card.dart';
import 'package:mitt_arv_movie_app/pages/movie_details_screen.dart';
import 'package:mitt_arv_movie_app/services/movie_api_service.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text("Favourites"),
            Icon(
              Icons.favorite,
              color: Colors.red,
            )
          ],
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   final movies = await MovieApiService.getFavouriteMovies();
      //   print(movies);
      // }),
      body: FutureBuilder(
        future: MovieApiService.getFavouriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Favourite Movies!",
                style: TextStyle(fontSize: 24, color: Colors.yellow),
              ),
            );
          }
         return Padding(
                padding: EdgeInsets.all(15.w),
                child: ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(MovieDetailsScreen(
                        fromFavourite: true,
                        imdbID: snapshot.data![index].imdbID,
                        movieName: snapshot.data![index].Title,
                      ));
                    },
                    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          Divider(),
          Text(snapshot.data![index].Title, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.yellow),textAlign: TextAlign.start,),
          Divider(),
          SizedBox(height: 10.h,),
          Image.network(snapshot.data![index].Poster,
          height: MediaQuery.of(context).size.height*0.4,
          width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 10.h,),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Rating"),
                  Text(snapshot.data![index].Rated),
                ],
              ),
              Column(
                children: [
                  Text("Year"),
                  Text(snapshot.data![index].Year),
                ],
              ),
              Column(
                children: [
                  Text("IMDB ID"),
                  Text(snapshot.data![index].imdbID),
                ],
              ),
            ],
          ),
        ),
        ],
      ),
    ),
                  ),
                  itemCount: snapshot.data!.length,
                ),
              );
        },
      ),
    );
  }
}
