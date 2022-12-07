import 'dart:developer';

import 'package:buzz/constants.dart';
import 'package:buzz/controllers/apicontroller1.dart';
import 'package:buzz/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import '../../controllers/productsFetch1.dart';
import '../../theme/Text.dart';
import 'components/color_dot.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.product}) : super(key: key);

  num product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  FetchProducts controller = Get.put(FetchProducts());

  var products = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        actions: [
          Icon(
            Icons.favorite,
            size: 36,
            color: Colors.red[300],
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => CartScreen());
                },
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.orange[900],
                  size: 40,
                ),
              ),
              Positioned(
                left: 17,
                top: 25,
                child: Text(
                  "1",
                  style: NormalTextBlack,
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Image.network(
            products[widget.product]['image'],
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[widget.product]['title'],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(width: defaultPadding),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(
                      products[widget.product]['description'],
                    ),
                  ),
                  Text(
                    "Colors",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          ColorDot(
                            color: Color(0xFFBEE8EA),
                            isActive: false,
                          ),
                          ColorDot(
                            color: Color(0xFF141B4A),
                            isActive: true,
                          ),
                          ColorDot(
                            color: Color(0xFFF4E5C3),
                            isActive: false,
                          ),
                        ],
                      ),
                      Text(
                        "\$" + products[widget.product]['price'].toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: const StadiumBorder()),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
