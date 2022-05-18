import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/services/business/getCategoriesService.dart';
import 'package:tivele/services/customer/customerAddLikeService.dart';
import 'package:tivele/services/customer/updateProfileImageService.dart';
class UpdateProfileImageController extends GetxController {
  var imageINfo = CheckApiResponseM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchUpdateImageData(File file,String filename, String userType) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await UpdateProfileImageService.fetchUpdateProfileImage(file, filename, userType);
    if (detail != null) {
      try {
        imageINfo.value = detail;
        if (imageINfo.value.status==200) {
          isLoading(false).obs;
          isListNull(false).obs;
        }
        else if(imageINfo.value.status==100){
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
