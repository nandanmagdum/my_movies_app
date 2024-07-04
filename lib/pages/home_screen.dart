import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mitt_arv_movie_app/constants/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          SizedBox(
            width: 15.w,
          ),
          Icon(
            Icons.logout,
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
