import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/constants/movie_card.dart';
import 'package:mitt_arv_movie_app/pages/get_started_screen.dart';
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
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   print("JWT TOKEN ");
      //   print(StorageService.pref.getString(StorageService.JWTTOKEN));
      // }, ),
      appBar: AppBar(
        leading: Icon(Icons.movie),
        title: TextFormField(
          decoration: InputDecoration(
              hintText: "Search Movies",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r))),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.settings_input_component)),
          SizedBox(
            width: 15.w,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          IconButton(
            onPressed: () {
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
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: ListView.builder(
          itemBuilder: (context, index) => MovieCard(),
          itemCount: 10,
        ),
      ),
    );
  }
}
