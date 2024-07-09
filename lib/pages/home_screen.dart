import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/constants/movie_card.dart';
import 'package:mitt_arv_movie_app/controllers/movie_controller.dart';
import 'package:mitt_arv_movie_app/pages/favourite_screen.dart';
import 'package:mitt_arv_movie_app/pages/get_started_screen.dart';
import 'package:mitt_arv_movie_app/pages/movie_details_screen.dart';
import 'package:mitt_arv_movie_app/services/api_service.dart';
import 'package:mitt_arv_movie_app/services/movie_api_service.dart';
import 'package:mitt_arv_movie_app/services/storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async{
      //   await ApiService.getFavFromDB();
      // }),
      appBar: AppBar(
        leading: Icon(Icons.movie),
        title: TextFormField(
          onFieldSubmitted: (value) async {
            final data = await MovieApiService.getMovieByName();
            print(data);
            setState(() {});
          },
          onChanged: (value) async {
            final data = await MovieApiService.getMovieByName();
            print(data);
            setState(() {});
          },
          controller: Get.find<MovieController>().search.value,
          decoration: InputDecoration(
              hintText: "Search Movies",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r))),
        ),
        centerTitle: true,
        actions: [
          IconButton(

              /// drop down menu code start
              onPressed: () {
                // show something
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Get.find<MovieController>().sortBy.value ==
                                    "title"
                                ? Icon(Icons.done)
                                : null,
                            title: Text('Title'),
                            onTap: () => Navigator.pop(context, 'title'),
                          ),
                          ListTile(
                            leading: Get.find<MovieController>().sortBy.value ==
                                    "rank"
                                ? Icon(Icons.done)
                                : null,
                            title: Text('Rank'),
                            onTap: () => Navigator.pop(context, 'rank'),
                          ),
                          ListTile(
                            leading: Get.find<MovieController>().sortBy.value ==
                                    "rating"
                                ? Icon(Icons.done)
                                : null,
                            title: Text('Rating'),
                            onTap: () => Navigator.pop(context, 'rating'),
                          ),
                          ListTile(
                            leading: Get.find<MovieController>().sortBy.value ==
                                    "year"
                                ? Icon(Icons.done)
                                : null,
                            title: Text('Year'),
                            onTap: () => Navigator.pop(context, 'year'),
                          ),
                        ],
                      ),
                    );
                  },
                ).then((value) {
                  Get.find<MovieController>()
                      .changeSortBy(sortCrieteria: value);
                  print(Get.find<MovieController>().sortBy.value);
                });
                ;
                // change the sorting crietetia
                // just change the listview builder
              },

              /// drop down menu code end
              icon: Icon(Icons.settings_input_component)),
          SizedBox(
            width: 15.w,
          ),
          IconButton(
            onPressed: () {
              Get.to(FavouriteScreen());
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          IconButton(
            onPressed: () async {
              ApiService.setFavToDB();
              Get.dialog(AlertDialog(
                title: Text("Are you sure ? You want to Log out ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        StorageService.pref.remove(StorageService.JWTTOKEN);
                        StorageService.pref.remove(StorageService.EMAIL);
                        print("Logged OUT");
                        Get.off(GetStartedScreen());
                      },
                      child: Text("Yes")),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("No")),
                ],
              ));
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
          SizedBox(
            width: 15.w,
          )
        ],
      ),
      body: Obx(
        () => Get.find<MovieController>().search.value.text.isEmpty
            ? FutureBuilder(
                future: MovieApiService.getTopRatedMovies(
                    sortBy: Get.find<MovieController>().sortBy.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No movies found"));
                  }
                  if (snapshot.data == null) {
                    print(snapshot.error);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(15.w),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(MovieDetailsScreen(
                            fromFavourite: false,
                            imdbID: snapshot.data![index].imdbid,
                            movieName: snapshot.data![index].title,
                          ));
                        },
                        child: MovieCard(
                          model: snapshot.data![index],
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  );
                },
              )
            : FutureBuilder(
                future: MovieApiService.getMovieByName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No movies found"));
                  }
                  if (snapshot.data == null) {
                    print(snapshot.error);
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text("${snapshot.error}"),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(15.w),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(MovieDetailsScreen(
                            fromFavourite: false,
                            imdbID: snapshot.data![index].imdbid,
                            movieName: snapshot.data![index].title,
                          ));
                        },
                        child: MovieCard(
                          model: snapshot.data![index],
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
