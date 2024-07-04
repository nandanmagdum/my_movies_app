
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController{
  Rx<TextEditingController> _email = TextEditingController().obs;
  Rx<TextEditingController> get email => _email;

  bool validateEmail() {
    return GetUtils.isEmail(_email.value.text);
  }
}