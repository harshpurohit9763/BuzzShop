import 'package:buzz/controllers/apicontroller1.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FetchProducts extends GetxController {
  Products products = Products();

  RxBool loading = false.obs;
  List productsList = [].obs;

  loadProductsFromRepo() async {
    loading(true);
    productsList = await products.loadProductsFromApi();
    print(productsList);
    loading(false);
  }

  var count = 0.obs;
  increment() {
    count++;
    update();
  }
}
