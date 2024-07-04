import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mitt_arv_movie_app/constants/buttons.dart';
import 'package:mitt_arv_movie_app/constants/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,),
            Text("Login", style: TextStyle(fontSize: 48.sp, fontWeight:FontWeight.bold),),
            kFormField(title: "Email", hintText: "Enter valid email address", textEditingController: emailController, context: context),
            kFormField(title: "Password", hintText: "Enter your password", textEditingController: passwordController, context: context),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.07,
            ),
            appButton(context: context, text: "Login")
          ],
        ),
      ),
    );
  }
}