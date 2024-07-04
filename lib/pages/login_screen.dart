import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mitt_arv_movie_app/constants/buttons.dart';
import 'package:mitt_arv_movie_app/constants/text_form_field.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/pages/home_screen.dart';
import 'package:mitt_arv_movie_app/services/api_service.dart';
import 'package:mitt_arv_movie_app/services/storage_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,),
            Text("Login", style: TextStyle(fontSize: 48.sp, fontWeight:FontWeight.bold),),
            kFormField(readonly: true ,title: "Email", hintText: "Enter valid email address", textEditingController: Get.find<EmailController>().email.value, context: context),
            Obx(() => kFormField(title: "Password", hintText: "Enter your password", textEditingController: Get.find<CreateAccountController>().passwordController.value, context: context, isPassword: true),),
            SizedBox(height: 5.h,),
            // Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         TextButton(onPressed: (){
            //           Get.find<CreateAccountController>().changePasswordVisibility();
            //         }, child: Obx(() => Get.find<CreateAccountController>().isPasswordVisible.value ? Text("show password"): Text("hide password"),),),
            //       ],
            //     ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.07,
            ),
            Obx(() => Get.find<LoadingController>().isLoading.value ? CircularProgressIndicator() : GestureDetector(
              onTap: () async{
                print(Get.find<EmailController>().email.value.text);
                print(Get.find<CreateAccountController>().passwordController.value.text);
                Get.find<LoadingController>().changeStatus();
                try {
                  final token = await ApiService.loginUser();
                  // show logged in succssfully
                  Get.snackbar("Logged In Successfully !", "Enjoy the app", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
                  // save token in local storage
                  StorageService.pref.setString(StorageService.JWTTOKEN, token);
                  StorageService.pref.setString(StorageService.EMAIL, Get.find<EmailController>().email.value.text);
                  print("jwt token saved");
                  // get off to home page
                  Get.off(HomeScreen());
                } catch (e) {
                  Get.snackbar(e.toString(), "Login API error", backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
                  Get.find<LoadingController>().changeStatus();
                  return ;
                }

                Get.find<LoadingController>().changeStatus();
              },
              child: appButton(context: context, text: "Login"),),),

          ],
        ),
      ),
    );
  }
}