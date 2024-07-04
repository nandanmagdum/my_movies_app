import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';

Column kFormField({
  required String title,
  required String hintText,
  required TextEditingController textEditingController,
  required BuildContext context,
  bool? isPassword,
  bool? isConfirmPassword,
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
          obscureText: isPassword ?? false
              ? !Get.find<CreateAccountController>().isPasswordVisible.value
              : isConfirmPassword ?? false
                  ? !Get.find<CreateAccountController>()
                      .isConfirmPasswordVisible
                      .value
                  : false,
          controller: textEditingController,
          decoration: InputDecoration(
            suffixIcon: isPassword ?? false
                ? IconButton(
                    onPressed: () {
                      Get.find<CreateAccountController>()
                          .changePasswordVisibility();
                    },
                    icon: Get.find<CreateAccountController>()
                            .isPasswordVisible
                            .value
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility))
                : isConfirmPassword ?? false
                    ? IconButton(
                        onPressed: () {},
                        icon: IconButton(
                            onPressed: () {
                              Get.find<CreateAccountController>()
                                  .changeConfirmPasswordVisibility();
                            },
                            icon: Icon(Get.find<CreateAccountController>()
                                    .isConfirmPasswordVisible
                                    .value
                                ? Icons.visibility_off
                                : Icons.visibility)))
                    : null,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ],
    );
