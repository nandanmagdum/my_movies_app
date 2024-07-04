import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/constants/buttons.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/loading_controller.dart';
import 'package:mitt_arv_movie_app/helper/validator.dart';
import 'package:mitt_arv_movie_app/pages/create_account_screen.dart';
import 'package:mitt_arv_movie_app/pages/login_screen.dart';
import 'package:mitt_arv_movie_app/services/api_service.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20))
          ..addListener(() {
            final maxScrollExtend = scrollController.position.maxScrollExtent;
            final ScrollPosition = animation.value * maxScrollExtend;
            scrollController.jumpTo(ScrollPosition);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Image(
                  image: AssetImage('assets/poster.jpg'),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 2.h),
                        child: Text(
                          "Nandan's Movie App",
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black),
                        )),
                  ),
                ),
                Container(
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    controller: Get.find<EmailController>().email.value,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
                ),
               
                Column(
                  children: [
                    Obx(() => Get.find<LoadingController>().isLoading.value ? CircularProgressIndicator() : GestureDetector(
                        onTap: () async{
                          final emailValidation = Validator.emailValidator(email: Get.find<EmailController>().email.value.text);
                          if(!emailValidation){
                            Get.snackbar("Enter valid email address", "Email address is badly formated", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                            return ;
                          }
                          Get.find<LoadingController>().changeStatus();
                          print(Get.find<EmailController>().email.value.text);
                          // call the user check api
                          try {
                            final status = await ApiService.checkIfUserExists();
                            print(status);
                            if(status){
                              Get.to(LoginScreen());
                            } else {
                              Get.to(CreateAccountScreen());
                            }
                            Get.find<LoadingController>().changeStatus();
                          } catch (e) {
                            Get.snackbar("${e}", "Error calling check user API", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
                            Get.find<LoadingController>().changeStatus();
                            return ;
                          }

                          // if exsisting user => navigate to login
                          // if new user => navigate to create account
                        },
                        child: appButton(context: context, text: "Continue")),),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
