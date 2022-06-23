// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:flutter/material.dart';
import '../screens/property_details_screen.dart';
import '../utils/color_theme.dart';
import 'cost_widget.dart';

class ResultWidget extends StatelessWidget {
  final Product product;
  const ResultWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          color: creamColor,
          elevation: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 1,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(1.2),
                  child: Image.network(
                    product.images[0],
                    filterQuality: FilterQuality.none,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Utils().showSnackBar(
                          context: context,
                          content: e.toString(),
                        ),
                      );
                    },
                    fit: BoxFit.fill,
                    width: screenSize.width / 2.2,
                    height: 135,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RentWidget(
                      color: Colors.black.withOpacity(0.8), rent: product.rent),
                  const SizedBox(height: 2),
                  Text(
                    "City: ${product.cityCategory}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  Text(
                    "Owner:\n${product.sellerName}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  InkWell(
                    focusColor: activeCyanColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailsScreen(product: product),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "More Details",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),

              // Text(
              //   product.cityCategory,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       SizedBox(
              //         width: screenSize.width / 6,
              //         child: FittedBox(
              //           child: RatingStarWidget(rating: product.rating),
              //         ),
              //       ),
              //       const SizedBox(width: 2),
              //       Text(
              //         product.noOfRating.toString(),
              //         style: const TextStyle(color: activeCyanColor),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              //   child: FittedBox(
              //     child: RentWidget(
              //       color: const Color.fromARGB(255, 147, 13, 4),
              //       rent: product.rent,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
