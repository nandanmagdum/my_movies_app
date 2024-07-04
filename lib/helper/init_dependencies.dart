import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';

class InitDependencies extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAccountController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => LoadingController());
    Get.lazyPut(() => EmailController());
  }
}