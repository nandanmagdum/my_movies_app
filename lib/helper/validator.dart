import 'package:get/get.dart';

class Validator {
 static String createAccountValidator(
    {
      required String name,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword
    }
  ){
    if(name == ""){
      return "Name cannot be empty";
    }
    if(email == ""){
      return "Email cannot be empty";
    }
    if(phone == ""){
      return "Phone Number cannot be empty";
    }
    if(password == ""){
      return "Password cannot be empty";
    }
    if(confirmPassword == ""){
      return "Confirm Password cannot be empty";
    }
    if(!GetUtils.isEmail(email)){
      return "Please Enter Valid Email";
    }
    if(!GetUtils.isPhoneNumber(phone)){
      return "Please Enter Valid Phone Number";
    }
    if(password != confirmPassword){
      return "Password do not match";
    }
    if(password.length < 8){
      return "Password must be atleast 8 characters";
    }
    return "ok";
  }

  static emailValidator({required String email}) {
    return GetUtils.isEmail(email);
  }
}