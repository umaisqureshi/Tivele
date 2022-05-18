import 'package:get/get.dart';
import 'package:tivele/globals.dart' as globals;
import 'package:tivele/models/checkApiResponseModel.dart';
import 'package:tivele/models/customer/getExploreDataModel.dart';
import 'package:tivele/models/customer/get_favorite_productsModel.dart';
import 'package:tivele/services/customer/GetFavoriteProductsService.dart';

class GetFavoriteProductsController extends GetxController {
  var myOrdersInfo = GetExploreDataM();
  var userInfo = CheckApiResponseM().obs;
  var isLoading = true.obs;
  var isListNull = false.obs;
  List<ProductDatum> myFavList = [];
  fetchfavouriteproduct() async {
    isLoading(true).obs;
    isListNull(true).obs;
    var detail = await GetFavoriteProductsService.fetchFavouriteProduct();
    myOrdersInfo = detail;
    if (detail == 600) {
      isLoading(false).obs;
      isListNull(true).obs;
      myOrdersInfo.status = 600;
      //globals.showErrorSnackBar("No Data Found!");
    } else if (detail != null) {
      try {
        // myOrdersInfo = detail;
        if (myOrdersInfo.status == 200) {
          isLoading(false).obs;
          isListNull(false).obs;
          myFavList = myOrdersInfo.data.map((element) {
            print(element.productImages);
            return element;
          }).toList();
        }else{
          isLoading(false).obs;
          isListNull(true).obs;
        }
      } catch (e) {
        isLoading(false).obs;
        isListNull(true).obs;
      }
    }else{
      isLoading(false).obs;
      isListNull(true).obs;
    }
  }
}
