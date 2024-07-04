import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';
import 'package:mitt_arv_movie_app/pages/get_started_screen.dart';
import 'package:mitt_arv_movie_app/helper/init_dependencies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(392.72, 848.72),
      child: GetMaterialApp(
        initialBinding: BindingsBuilder(() {
          Get.put(CreateAccountController());
          Get.put(EmailController());
          Get.put(LoadingController());
          Get.put(OtpController());
        }),
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: GetStartedScreen(),
      ),
    );
  }
}