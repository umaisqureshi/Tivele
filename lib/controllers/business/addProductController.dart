import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/services/business/addProductService.dart';
import 'package:tivele/globals.dart' as globals;
import 'package:tivele/views/business/businessProfilePage.dart';
class AddProductController extends GetxController {
  var productINfo = CheckApiResponseM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchProduct(Map<dynamic, dynamic> userData) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await AddProductService.fetchProductData(userData);
    if (detail != null) {
      try {
        productINfo.value = detail;
        if (productINfo.value.status==200) {
          isLoading(false).obs;
          globals.showSuccesSnackBar(productINfo.value.data);
          Get.offAll(BusinessProfilePage());
        }
        else if(productINfo.value.status==100){
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
