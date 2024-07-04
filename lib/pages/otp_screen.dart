import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mitt_arv_movie_app/constants/buttons.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';
import 'package:mitt_arv_movie_app/pages/create_account_screen.dart';
import 'package:mitt_arv_movie_app/pages/get_started_screen.dart';
import 'package:mitt_arv_movie_app/pages/login_screen.dart';
import 'package:mitt_arv_movie_app/services/api_service.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,),
            Text("Enter OTP sent to", style: TextStyle(fontSize: 18.sp,), textAlign: TextAlign.center,),
            Text("${Get.find<EmailController>().email.value.text}", style: TextStyle(fontSize: 18.sp,color: Colors.yellow), textAlign: TextAlign.center,),
            SizedBox(height: 40.h,),
            Padding(
              padding: EdgeInsets.all(6.0),
              child: Pinput(
                length: 6,
                autofocus: true,
                onChanged: (value){
                  Get.find<OtpController>().otp.value = value;
                  print(Get.find<OtpController>().otp.value);
                },
                onCompleted: (value){
                  // TODO : api call for verification of OTP
                  // if status is good
                    // create account and send user to login screen
                  // else display something went wrong and return to create account screen
                },
              ),
              ),
              SizedBox(height: 80.h,),
              Obx(() => Get.find<LoadingController>().isLoading.value ? CircularProgressIndicator() :GestureDetector(
                onTap: () async{
                  Get.find<LoadingController>().changeStatus();
                  try {
                    final apiStatus = await ApiService.verifyOTP();
                    if(apiStatus){
                      // create account API
                      final apiStatus = await ApiService.createAccount();
                      if(apiStatus){
                        Get.snackbar("Account Created Successfully !", "Welcome", backgroundColor: Colors.green);
                        Get.off(LoginScreen());
                      } else {
                        Get.snackbar("Failed To Create New Account", "SOMETHING WENT WRONG !", backgroundColor: Colors.green);
                        Get.off(GetStartedScreen());
                      }
                    } else {
                      Get.off(CreateAccountScreen());
                    }
                  } catch (e) {
                    Get.snackbar(e.toString(), "OTP API failed !");
                    Get.off(CreateAccountScreen());
                  }
                  Get.find<LoadingController>().changeStatus();
                },
                child: appButton(context: context, text: "Verify OTP")))
          ],
        ),
      ),
    );
  }
}