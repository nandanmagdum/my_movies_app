import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';

Column kFormField(
        {required String title,
        required String hintText,
        required TextEditingController textEditingController,
        required BuildContext context,
        bool? isPassword,
        bool? readonly,
        }) =>
    Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        TextFormField(
          readOnly: readonly ?? false,
          obscureText: isPassword?? false ? Get.find<CreateAccountController>().isPasswordVisible.value : false,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ],
    );
