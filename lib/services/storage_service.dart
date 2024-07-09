import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences pref;
  static Future<void> init() async{
    pref = await SharedPreferences.getInstance();
  }
  static const JWTTOKEN = "jwtToken";
  static const EMAIL = "email";
  static const LIKED = "liked";
}