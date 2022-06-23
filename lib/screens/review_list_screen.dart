// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/multi_image_product_model.dart';
import '../model/review_model.dart';
import '../utils/color_theme.dart';
import '../utils/input_decoration.dart';
import '../widgets/review_widget.dart';

class ReviewListScreen extends StatefulWidget {
  final Product product;
  const ReviewListScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REVIEWS"),
        backgroundColor: darkCreamColor,
      ),


      body: SizedBox(
        height: screenSize.height / 1.2,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("products")
              .doc(widget.product.uid)
              .collection("reviews")
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ReviewModel model = ReviewModel.getModelFromJson(
                          json: snapshot.data!.docs[index].data());
                      return ReviewWidget(review: model);
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
