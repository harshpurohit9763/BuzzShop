import 'package:buzz/controllers/productsFetch2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import 'product_card.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  FetchProductsFromapi2 controller = Get.put(FetchProductsFromapi2());
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
            title: "Popular",
            pressSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              demo_product.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: controller.productsList[index]['title'],
                  image: controller.productsList[index]['category']['image'],
                  price: controller.productsList[index]["price"],
                  bgColor: demo_product[index].bgColor,
                  press: () {
                    Get.to(
                        DetailsScreen(
                          product: index,
                        ),
                        arguments: [controller.productsList]);
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
