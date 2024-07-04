import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final Rx<TextEditingController> _nameController = TextEditingController().obs;
  // final Rx<TextEditingController> _emailController = TextEditingController().obs;
  final Rx<TextEditingController> _passwordController = TextEditingController().obs;
  final Rx<TextEditingController> _confirmPasswordController = TextEditingController().obs;
  final Rx<TextEditingController> _phoneController = TextEditingController().obs;
  final Rx<bool> _isPasswordVisible = false.obs;
  final Rx<bool> _isConfirmPasswordVisible = false.obs;

  Rx<TextEditingController> get nameController  => _nameController;
  // Rx<TextEditingController> get emailController  => _emailController;
  Rx<TextEditingController> get passwordController  => _passwordController;
  Rx<TextEditingController> get confirmPasswordController  => _confirmPasswordController;
  Rx<TextEditingController> get phoneController  => _phoneController;
  Rx<bool> get isPasswordVisible => _isPasswordVisible;
  Rx<bool> get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void changePasswordVisibility() {
    _isPasswordVisible.value =  !_isPasswordVisible.value;
  }

  void changeConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value =  !_isConfirmPasswordVisible.value;
  }
}
