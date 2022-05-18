import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/customer/getBusinessProfileByIdModel.dart';
import 'package:tivele/globals.dart' as globals;
import 'package:tivele/services/customer/getBusinessProfileByIdService.dart';
import 'package:tivele/services/customer/getExploreDataService.dart';
class GetBusinessProfileByIdController extends GetxController {
  var businessINfo = GetBusinessProfileByIdM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchGetBusinessProfileByIdData(String businessId) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await GetBusinessProfileByIdService.fetchGetBusinessProfileByIdData(businessId);
    if (detail == 600){
      isLoading(false).obs;
      isListNull(true).obs;
      businessINfo.value.status = 600;
      globals.showErrorSnackBar("No Data Found!");
    }else if (detail != null) {
      try {
        businessINfo.value = detail;
        if (businessINfo.value.status==200) {
          isLoading(false).obs;
          isListNull(false).obs;

        }
        else if(businessINfo.value.status==100){
          isLoading(false).obs;
          isListNull(true).obs;
          globals.showErrorSnackBar(businessINfo.value.message);
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
