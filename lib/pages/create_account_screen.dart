import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/constants/buttons.dart';
import 'package:mitt_arv_movie_app/constants/text_form_field.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/pages/otp_screen.dart';
import 'package:mitt_arv_movie_app/helper/validator.dart';
import 'package:mitt_arv_movie_app/services/api_service.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "Create Account",
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
              ),
              kFormField(
                  title: "Name",
                  hintText: "Enter your name",
                  textEditingController:
                      Get.find<CreateAccountController>().nameController.value,
                  context: context),
              // kFormField(title: "Email", hintText: "Enter valid email address", TextEditingController: Get.find<CreateAccountController>().emailController.value, context: context),
              kFormField(
                  title: "Phone Number",
                  hintText: "+911234567890",
                  textEditingController:
                      Get.find<CreateAccountController>().phoneController.value,
                  context: context),
              Obx(
                () => kFormField(
                    title: "Password",
                    hintText: "Enter your password",
                    textEditingController: Get.find<CreateAccountController>()
                        .passwordController
                        .value,
                    context: context,
                    isPassword: true),
              ),
              Obx(() => kFormField(
                  title: "Confirm Password",
                  hintText: "Re-enter your password",
                  textEditingController: Get.find<CreateAccountController>()
                      .confirmPasswordController
                      .value,
                  context: context,
                  isPassword: true),),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Get.find<CreateAccountController>().changePasswordVisibility();
                    }, child: Obx(() => Get.find<CreateAccountController>().isPasswordVisible.value ? Text("show password"): Text("hide password"),),),
                  ],
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Obx(
                () => Get.find<LoadingController>().isLoading.value
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          Get.find<LoadingController>().changeStatus();
                          final String status =
                              Validator.createAccountValidator(
                                  name: Get.find<CreateAccountController>()
                                      .nameController
                                      .value
                                      .text,
                                  email: Get.find<EmailController>()
                                      .email
                                      .value
                                      .text,
                                  phone: Get.find<CreateAccountController>()
                                      .phoneController
                                      .value
                                      .text,
                                  password: Get.find<CreateAccountController>()
                                      .passwordController
                                      .value
                                      .text,
                                  confirmPassword:
                                      Get.find<CreateAccountController>()
                                          .confirmPasswordController
                                          .value
                                          .text);
                          if (status != "ok") {
                            Get.snackbar(status, "Please Enter Valid data",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red);
                            Get.find<LoadingController>().changeStatus();
                            return;
                          }
                          // call API
                          try {
                            final apiStatus = await ApiService.sendOTPToEmail();
                            if (apiStatus == false) {
                              Get.snackbar(
                                  "Something went wrong", "please try again");
                            } else {
                              Get.snackbar(
                                  "OTP sent to ${Get.find<EmailController>().email.value.text}",
                                  "Please check your email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green);
                              Get.off(() => OtpScreen());
                            }
                            Get.find<LoadingController>().changeStatus();
                          } catch (e) {
                            Get.snackbar(e.toString(), "Error sending OTP");
                            Get.find<LoadingController>().changeStatus();
                            return;
                          }
                        },
                        child: appButton(
                            context: context, text: "Create New Account")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
