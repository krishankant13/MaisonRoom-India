// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/widgets/loading_widget.dart';
import 'package:maison_room/widgets/result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/profile/profile_page_one.dart';

import '../utils/color_theme.dart';

class RenterTypeResultScreen extends StatelessWidget {
  final String query;
  const RenterTypeResultScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkCreamColor),
        elevation: 0.2,
        title: Text(
          "Property Collection",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: darkCreamColor),
        ),
        backgroundColor: creamColor,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Showing Result : ',
                          style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
                        ),
                        TextSpan(
                          text: query,
                          style: TextStyle(
                            fontSize: 17,
                            color: activeCyanColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where("renterCategory", isEqualTo: query.inCaps)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 2,

                        //   ),
                        itemBuilder: (context, index) {
                          return ResultWidget(
                              product: Product.getModelFromJson(
                                  json: snapshot.data!.docs[index].data()));
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
