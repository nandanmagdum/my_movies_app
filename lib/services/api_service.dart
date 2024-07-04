import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';

class ApiService {
  static const baseUrl = "https://mitt-arv-assignment-movie-app.onrender.com/";

  static Future<void> testAPI()async{
    final URI = Uri.parse(baseUrl);
    final response = await http.get(URI);
    if(response.statusCode != 200){
      throw Exception("Test API call failed !");
    }
    final data = jsonDecode(response.body);
    print(data);
  }

  static Future<bool> sendOTPToEmail() async{
    final URI = Uri.parse(baseUrl+"auth/sendOTP");
    final response = await http.post(URI, body: {
      "email": "${Get.find<EmailController>().email.value.text}"
    });
    final data = jsonDecode(response.body);
    if(response.statusCode != 200){
      throw Exception(data);
    }
    print("##############################");
    print(data);
    return true;
  }

  static Future<bool> verifyOTP() async{
    final URI = Uri.parse(baseUrl+"auth/verifyOTP");
    final response = await http.post(URI, body: {
      "email": Get.find<EmailController>().email.value.text,
      "otp": Get.find<OtpController>().otp.value
    });
    final data =jsonDecode(response.body);
    final statusCode = response.statusCode;
    if(statusCode != 200){
      throw Exception(data);
    }
    else {
      return true;
    }
  }

  static Future<bool> createAccount() async{
    final URI = Uri.parse(baseUrl+"auth/createNewUser");
    final response = await http.post(URI, body: {
      "name":  Get.find<CreateAccountController>().nameController.value.text,
      "phone": Get.find<CreateAccountController>().phoneController.value.text,
      "email": Get.find<EmailController>().email.value.text,
      "password" : Get.find<CreateAccountController>().passwordController.value.text
    });
    final data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if(statusCode == 200){
      return true;
    } else {
      throw Exception(data);
    }
  }

  static Future<bool> checkIfUserExists() async{
    final URI = Uri.parse(baseUrl+"auth/check");
    print("******************************************************************************");
    print(Get.find<EmailController>().email.value.text);
    final response = await http.post(URI, body: {
      "email": Get.find<EmailController>().email.value.text
    });
    final data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      return data;
    } else {
      throw Exception(data);
    }
  }

  static Future<String> loginUser() async{
    print(Get.find<EmailController>().email.value.text);
    print(Get.find<EmailController>().email.value.text);
    final URI = Uri.parse(baseUrl+"auth/login");
    final response = await http.post(URI, body: {
      "email": Get.find<EmailController>().email.value.text,
      "password": Get.find<CreateAccountController>().passwordController.value.text
    });
    final data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if(statusCode != 200){
      throw Exception(data);
    }
    else {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(data['token']);
      return data['token'];
    }
  }
}