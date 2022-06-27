// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/screens/property_request_screen.dart';
import 'package:maison_room/utils/color_theme.dart';
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
        backgroundColor: Colors.white,
        body: Column(
          children: [
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
                    return PropertyRequestScreen();
             
                  } else {
                    return Scaffold(
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
                      body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Result: ',
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: query == ''
                                                ? query
                                                : query.inCaps,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "More Property",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: activeCyanColor),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_sharp,
                                            color: Colors.blue,
                                            size: 17,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 2,

                              //   ),
                              itemBuilder: (context, index) {
                                return ResultWidget(
                                    product: Product.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data()));
                              },
                            ),
                          ],
                        ),
                      ),
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
