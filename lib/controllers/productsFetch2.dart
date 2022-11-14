import 'package:buzz/controllers/apiController2.dart';
import 'package:buzz/controllers/apicontroller1.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FetchProductsFromapi2 extends GetxController {
  Products2 products2 = Products2();

  RxBool loading = false.obs;
  List productsList = [].obs;

  loadProductsFromRepo() async {
    loading(true);
    productsList = await products2.loadProductsFromApi();
    print(productsList);
    loading(false);
  }
}
