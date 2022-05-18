import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tivele/models/customer/customerHomeModel.dart';
import 'package:tivele/models/customer/getExploreDataModel.dart';
import 'package:tivele/services/customer/customerHomeService.dart';
import 'package:tivele/globals.dart' as globals;
import 'package:tivele/services/customer/getExploreDataService.dart';
import 'package:tivele/services/customer/getTiveleDataService.dart';
class GetTiveleDataController extends GetxController {
  var tiveleDataINfo = GetExploreDataM().obs;
  var isLoading = false.obs;
  var isListNull = false.obs;
  void fetchTiveleData(String pageNumber, String longitude, String latitude) async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await GetTiveleDataService.fetchTiveleData(pageNumber, longitude, latitude);
    if (detail == 600){
      isLoading(false).obs;
      isListNull(true).obs;
      tiveleDataINfo.value.status = 600;
      // globals.showErrorSnackBar("No Data Found!");
    }else if (detail != null) {
      try {
        tiveleDataINfo.value = detail;
        if (tiveleDataINfo.value.status==200) {
          isLoading(false).obs;
          isListNull(false).obs;

        }
        else if(tiveleDataINfo.value.status==100){
          isLoading(false).obs;
          isListNull(true).obs;
          //globals.showErrorSnackBar(exploreINfo.value.message);
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
