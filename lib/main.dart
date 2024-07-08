import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/controllers/movie_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';
import 'package:mitt_arv_movie_app/pages/get_started_screen.dart';
import 'package:mitt_arv_movie_app/pages/home_screen.dart';
import 'package:mitt_arv_movie_app/services/storage_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
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
          Get.put(MovieController());
        }),
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: (StorageService.pref.getString(StorageService.JWTTOKEN) != null) ? HomeScreen() : GetStartedScreen(),
      ),
    );
  }
}