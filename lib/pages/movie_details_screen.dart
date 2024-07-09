import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/models/general_movie.dart';
import 'package:mitt_arv_movie_app/models/movie_details_model.dart';
import 'package:mitt_arv_movie_app/services/movie_api_service.dart';
import 'package:mitt_arv_movie_app/services/storage_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final bool fromFavourite;
  final String imdbID;
  final String movieName;
  const MovieDetailsScreen(
      {super.key, required this.imdbID, required this.movieName, required this.fromFavourite});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   print(StorageService.pref.getStringList(StorageService.LIKED));
      // }),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: (){
         if(widget.fromFavourite){
          Get.back();
          Get.back();
         } else {
          Get.back();
         }
        },),
        title: Text(widget.movieName),
        actions: [
          IconButton(
            onPressed: () {
              List<String> liked = StorageService.pref.getStringList(StorageService.LIKED) ?? <String>[];
              if(liked.contains(widget.imdbID)){
                liked.remove(widget.imdbID);
              }else {
                liked.add(widget.imdbID);
              }
              StorageService.pref.setStringList(StorageService.LIKED, liked);
              setState(() {
              });
            },
            icon: Icon(
              Icons.favorite,
              color: StorageService.pref
                          .getStringList(StorageService.LIKED)
                          ?.contains(widget.imdbID) ??
                      false
                  ? Colors.red
                  : Colors.white,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: FutureBuilder(
        future: MovieApiService.getMovieByImdbId(imdbID: widget.imdbID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          MovieDetailsModel movie = snapshot.data ?? MovieDetailsModel.fromJson(generalMovie);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          movie.Title,
                          style: TextStyle(fontSize: 38.sp),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(movie.Year),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(movie.Rated),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(movie.Runtime),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  (movie.Poster != "N/A")? Image.network(movie.Poster) : Image.asset("assets/movie.jpg"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(movie.imdbRating),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.attach_money_rounded),
                            SizedBox(
                              height: 5,
                            ),
                            Text(movie.BoxOffice),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.how_to_vote),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              movie.imdbVotes,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description: ",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(movie.Plot),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Released: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(movie.Released),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "Genere: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(movie.Genre),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Languages: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Flexible(child: Text(movie.Language)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Director: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Flexible(child: Text(movie.Director)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Writer: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Flexible(child: Text(movie.Director)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Actors: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Flexible(child: Text(movie.Actors)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Country: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Flexible(child: Text(movie.Country)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "MetaScore: ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(movie.Metascore),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Awards: ",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movie.Awards),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
