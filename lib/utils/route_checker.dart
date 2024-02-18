import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteChecker {
  static bool checkIfCurrentRoute(String routeName) {
    if (Get.currentRoute == routeName) {
      return true;
    } else {
      return false;
    }
  }
}