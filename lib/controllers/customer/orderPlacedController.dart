import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/services/customer/orderPlacedService.dart';
import 'package:tivele/services/customer/updateUserPasswordService.dart';
import 'package:tivele/views/customer/thankyouPage.dart';
import 'package:tivele/globals.dart' as globals;
class OrderPlacedController extends GetxController {
  var orderINfo = CheckApiResponseM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchOrderPlaced(Map<dynamic, dynamic> userData) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await OrderPlacedService.fetchOrderPlaced(userData);
    if (detail != null) {
      try {
        orderINfo.value = detail;
        if (orderINfo.value.status==200){
          isLoading(false).obs;
          isListNull(false).obs;
          Get.offAll(ThankyouPage());
        }
        else if(orderINfo.value.status==600){
          isLoading(false).obs;
          isListNull(false).obs;
          globals.showErrorSnackBar("Not Subitted Data!");
        }
        else {
          isLoading(false).obs;
          isListNull(true).obs;
          globals.showErrorSnackBar("Not Subitted Data!");
        }
      } catch (e) {
        print(e);
        isLoading(false).obs;
        isListNull(false).obs;
        Get.snackbar(
          "Error",
          "Data is not getting!",
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        // TODO
      }
    } else {
      isLoading(false).obs;
      isListNull(false).obs;
      Get.snackbar(
        "Error",
        "User inactive",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.primaryColor,
        colorText: Colors.white,
      );
    }
  }
}
