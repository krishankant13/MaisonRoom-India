// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/profile/profile_page_one.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:maison_room/widgets/cart_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/widgets/loader.dart';

import '../utils/color_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          
          elevation: 0.5,
          backgroundColor: creamColor,
          title: Text(
            "Your Shortlist",
          style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkCreamColor.withOpacity(0.9)),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black.withOpacity(0.8),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePageOne(),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('cart')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Loader());
              } else if (snapshot.connectionState ==
                  ConnectionState.none) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text("Something Went Wrong!"),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: screenSize.height/3,),
                      Text(
                        "No Result Found!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView.builder(
                   shrinkWrap: true,
                   physics:NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Product product = Product.getModelFromJson(
                        json: snapshot.data!.docs[index].data(),
                      );

                      return CartItemWidget(
                        product: product,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
