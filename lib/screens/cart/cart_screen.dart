import 'package:buzz/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components/cartitem.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firebaseFirestore
            .collection('UserData')
            .doc(auth.currentUser!.uid)
            .collection('cart')
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        snapshot.data!.docs[index]['image'],
                        width: 100,
                      ),
                      IconButton(
                          onPressed: () async {
                            await firebaseFirestore
                                .collection('UserData')
                                .doc(auth.currentUser!.uid)
                                .collection('cart')
                                .doc()
                                .delete();
                          },
                          icon: Icon(Icons.remove))
                    ],
                  ),
                  Text(snapshot.data!.docs[index]['name']),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
