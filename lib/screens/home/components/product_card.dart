import 'dart:ffi';

import 'package:buzz/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/productsFetch1.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.press,
    required this.price,
    required this.bgColor,
    required this.image,
    required this.title,
  }) : super(key: key);
  late String image, title;
  final VoidCallback press;
  final num price;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    FetchProducts controller = Get.put(FetchProducts());

    return GestureDetector(
      onTap: press,
      child: Container(
        width: 154,
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(
                    Radius.circular(defaultBorderRadius)),
              ),
              child: Image.network(
                image,
                height: 132,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "\$" + price.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
