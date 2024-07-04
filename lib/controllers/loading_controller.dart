import 'package:get/get.dart';

class LoadingController extends GetxController {
  Rx<bool> _isLoading = false.obs;
  Rx<bool> get isLoading => _isLoading;

  void changeStatus(){
    _isLoading.value = !_isLoading.value;
  }
}