import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/services/business/getCategoriesService.dart';
import 'package:tivele/services/customer/businessFollowService.dart';
import 'package:tivele/services/customer/customerAddLikeService.dart';
class BusinessFollowController extends GetxController {
  var addFollowINfo = CheckApiResponseM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchAddFollow(Map<dynamic, dynamic> userData) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await BusinessFollowService.fetchAddFollow(userData);
    if (detail != null) {
      try {
        addFollowINfo.value = detail;
        if (addFollowINfo.value.status==200) {
          isLoading(false).obs;
          isListNull(false).obs;
        }
        else if(addFollowINfo.value.status==100){
          isLoading(false).obs;
          isListNull(true).obs;
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
