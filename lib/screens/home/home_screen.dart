import 'package:buzz/controllers/productsFetch2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants.dart';
import '../../controllers/productsFetch1.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FetchProducts controller = Get.put(FetchProducts());
  FetchProductsFromapi2 controllerOfApi2 = Get.put(FetchProductsFromapi2());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadProductsFromRepo();
    controllerOfApi2.loadProductsFromRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/Location.svg"),
              const SizedBox(width: defaultPadding / 2),
              Text(
                "15/2 New Texas",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset("assets/icons/Notification.svg"),
              onPressed: () {},
            ),
          ],
        ),
        body: Obx(() {
          return controller.loading.value
              ? Center(
                child: CircularProgressIndicator(color: Colors.orange[900]),
              )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buzz...",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      const Text(
                        "With the latest you",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding),
                        child: SearchForm(),
                      ),
                      Categories(),
                      NewArrivalProducts(),
                      PopularProducts(),
                    ],
                  ),
                );
        }));
  }
}
