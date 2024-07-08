import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MovieController extends GetxController{
  
  // sorting movies
  Rx<String> _sortBy = "null".obs;
  Rx<String> get sortBy => _sortBy;

  // search controller
  Rx<TextEditingController> _search = TextEditingController().obs;
  Rx<TextEditingController> get search => _search;

  void changeSortBy({String? sortCrieteria}){
    _sortBy.value = sortCrieteria ?? _sortBy.value;
  }
}