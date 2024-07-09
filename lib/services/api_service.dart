import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mitt_arv_movie_app/controllers/create_account_controller.dart';
import 'package:mitt_arv_movie_app/controllers/email_controller.dart';
import 'package:mitt_arv_movie_app/controllers/otp_controller.dart';
import 'package:mitt_arv_movie_app/services/storage_service.dart';

class ApiService {
  static Dio dio = Dio();
  static const baseUrl = "https://mitt-arv-assignment-movie-app.onrender.com/";

  static Future<void> testAPI() async {
    final URI = Uri.parse(baseUrl);
    final response = await http.get(URI);
    if (response.statusCode != 200) {
      throw Exception("Test API call failed !");
    }
    final data = jsonDecode(response.body);
    print(data);
  }

  static Future<bool> sendOTPToEmail() async {
    final URI = Uri.parse(baseUrl + "auth/sendOTP");
    final response = await http.post(URI,
        body: {"email": "${Get.find<EmailController>().email.value.text}"});
    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception(data);
    }
    print("##############################");
    print(data);
    return true;
  }

  static Future<bool> verifyOTP() async {
    final URI = Uri.parse(baseUrl + "auth/verifyOTP");
    final response = await http.post(URI, body: {
      "email": Get.find<EmailController>().email.value.text,
      "otp": Get.find<OtpController>().otp.value
    });
    final data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception(data);
    } else {
      return true;
    }
  }

  static Future<bool> createAccount() async {
    final URI = Uri.parse(baseUrl + "auth/createNewUser");
    final response = await http.post(URI, body: {
      "name": Get.find<CreateAccountController>().nameController.value.text,
      "phone": Get.find<CreateAccountController>().phoneController.value.text,
      "email": Get.find<EmailController>().email.value.text,
      "password":
          Get.find<CreateAccountController>().passwordController.value.text
    });
    final data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      return true;
    } else {
      throw Exception(data);
    }
  }

  static Future<bool> checkIfUserExists() async {
    final URI = Uri.parse(baseUrl + "auth/check");
    print(
        "******************************************************************************");
    print(Get.find<EmailController>().email.value.text);
    final response = await http.post(URI,
        body: {"email": Get.find<EmailController>().email.value.text});
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data);
    }
  }

  static Future<String> loginUser() async {
    print(Get.find<EmailController>().email.value.text);
    print(Get.find<EmailController>().email.value.text);
    final URI = Uri.parse(baseUrl + "auth/login");
    final response = await http.post(URI, body: {
      "email": Get.find<EmailController>().email.value.text,
      "password":
          Get.find<CreateAccountController>().passwordController.value.text
    });
    final data = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      throw Exception(data);
    } else {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(data['token']);
      return data['token'];
    }
  }

  static Future<void> getFavFromDB() async {
    final URI = Uri.parse(baseUrl + "user/favourites");
    final jwt = StorageService.pref.getString(StorageService.JWTTOKEN) ?? "";
    final email = StorageService.pref.getString(StorageService.EMAIL);
    print(jwt);
    print(email);
    // TODO : Change from backend
    final response = await http.post(URI, headers: {
      "Authorization": jwt,
    }, body: {
      "email": email
    });
    final data = jsonDecode(response.body);
    if(data['ids'].isEmpty){
      return;
    }
    print("ASGD OIAUSGD YAGSDIYU SIDUYF AISDF IASUYD IASYUFDIUASFDIU FASUDFY ");
    print(data['ids']);
    List<String> liked = [];
    for(int i=0;  i < data['ids'].length; i++)
    {
      liked.add(data['ids'][i]);
    }
    StorageService.pref.setStringList(StorageService.LIKED, liked);
  }

  static Future<bool> setFavToDB() async {
    try {
      print(1);
      final URI = Uri.parse(baseUrl + "user/addAllFav");
      print(2);
      final jwt = StorageService.pref.getString(StorageService.JWTTOKEN) ??
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im5hbmRhbm1hZ2R1bTE0QGdtYWlsLmNvbSIsIm5hbWUiOiJOYW5kYW4gTWFnZHVtIiwicGhvbmUiOiIrOTE4MTgwMDk3NTkwIiwiaWF0IjoxNzIwNTE5MzcwLCJleHAiOjE3MjMxMTEzNzB9.wz8kBIwEZH8wwMfZafc9dXGucwSbn6gWJs-Mt0diphA";
      final ids =
          StorageService.pref.getStringList(StorageService.LIKED) ?? <String>[];
      print(jwt);
      print(ids);
      Map<String, dynamic> requestData = {
        "favourites": ids
      };
      //////////////////////////////////////////////////////////////////////
      final response = await dio.post(baseUrl+"user/addAllFav", options: Options(headers: {
        "Authorization": jwt
      }
      ),
      data: requestData
      );
      /////////////////////////////////////////////////////////////////////////
      print(3);
      if (response.statusCode == 200) {
        print(4);
        return true;
      }
      print(5);
      return false;
    } catch (e) {
      print(6);
      print(e);
    }
    return false;
  }
}
