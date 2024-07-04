import 'package:get/get.dart';

class OtpController extends GetxController {
  Rx<String> _otp = "".obs;
  Rx<String> get otp => _otp;
}