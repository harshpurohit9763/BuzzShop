import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/productsFetch1.dart';
import '../../details/details_screen.dart';
import 'product_card.dart';
import 'section_title.dart';

class NewArrivalProducts extends StatefulWidget {
  NewArrivalProducts({
    Key? key,
  }) : super(key: key);
  @override
  State<NewArrivalProducts> createState() => _NewArrivalProductsState();
}

class _NewArrivalProductsState extends State<NewArrivalProducts> {
  FetchProducts controller = Get.put(FetchProducts());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadProductsFromRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "New Arrival",
            pressSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: controller.productsList[index]['title'],
                  image: controller.productsList[index]['image'],
                  price: controller.productsList[index]["price"],
                  bgColor: bgColor,
                  press: () {
                    Get.to(
                      DetailsScreen(
                        product: index,
                      ),
                      arguments: [controller.productsList],
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
