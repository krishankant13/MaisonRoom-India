// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/widgets/loading_widget.dart';
import 'package:maison_room/widgets/result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/profile/profile_page_one.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Results",
            style: TextStyle(
              fontSize: 17,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w600),
                 overflow: TextOverflow.ellipsis,
          ),
          backgroundColor: Colors.white,
          elevation: 0.9,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Search Result: ',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                          
                        ),
                      ),
                      TextSpan(
                        text: query == '' ? query : query.inCaps,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w600,
                          
                        ),
                        
                      ),
                    ],
                  ),
                   overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .where("cityCategory",
                        isEqualTo: query == '' ? query : query.inCaps)
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
    );
  }
}
