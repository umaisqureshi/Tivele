import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/services/customer/orderReviewService.dart';
import 'package:tivele/globals.dart' as globals;
class OrderReviewController extends GetxController {
  var orderReviewINfo = CheckApiResponseM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchOrderReview(Map<dynamic, dynamic> userData) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await OrderReviewService.fetchOrderReview(userData);
    if (detail != null) {
      try {
        orderReviewINfo.value = detail;
        if (orderReviewINfo.value.status==200) {
          isLoading(false).obs;
          globals.showSuccessToast("Review added successfully.");
        }
        else if(orderReviewINfo.value.status==700){
          isLoading(false).obs;
          globals.showErrorToast("Already Reviewd!");
        }
        else {
          isLoading(false).obs;
          isListNull(true).obs;
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
