import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/customer/customerHomeModel.dart';
import 'package:tivele/models/customer/getExploreDataModel.dart';
import 'package:tivele/services/customer/customerHomeService.dart';
import 'package:tivele/globals.dart' as globals;
class CustomerHomeController2 extends GetxController {
  var homeINfo = GetExploreDataM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchCustomerHomeData(String pageNumber) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await CustomerHomeService.fetchHomeData(pageNumber);
    if (detail == 600){
      isLoading(false).obs;
      isListNull(true).obs;
      homeINfo.value.status = 600;
      // Get.snackbar(
      //     "Notification",
      //     "No more items to show!",
      //     icon: Icon(
      //       Icons.error_outline,
      //       color: Colors.black,
      //     ),
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: Colors.white,
      //     colorText: Colors.black,
      //     snackbarStatus: (status) {
      //       print(status);
      //       if (status == SnackbarStatus.CLOSED) {
      //       }
      //     }
      // );
    }else if (detail != null) {
      try {
        homeINfo.value = detail;
        if (homeINfo.value.status==200) {
          isLoading(false).obs;
          isListNull(false).obs;

        }
        else if(homeINfo.value.status==100){
          isLoading(false).obs;
          isListNull(true).obs;
          globals.showErrorSnackBar(homeINfo.value.message);
        }
        else {
          isLoading(false).obs;
          Get.snackbar(
            "Error!",
            "Credentials not correct or user inactive 1",
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            snackPosition: SnackPosition.TOP,
            backgroundColor:  Colors.orange,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print(e);
        isLoading(false).obs;
        Get.snackbar(
          "Error!",
          "Credentials not correct or user inactive 2",
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          backgroundColor:  Colors.orange,
          colorText: Colors.white,
        );

        // TODO
      }
    } else {
      isLoading(false).obs;
      Get.snackbar(
        "Error!",
        "Credentials not correct or user inactive 3",
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor:  Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
