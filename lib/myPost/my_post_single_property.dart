// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/myPost/Edit_Property_screeen.dart';
import 'package:maison_room/utils/input_decoration.dart';
import '../screens/property_details_screen.dart';
import '../utils/color_theme.dart';

class MyPostSingleProperty extends StatelessWidget {
  final Product product;

  const MyPostSingleProperty({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        color: creamColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            color: Colors.white,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: screenSize.height / 5.5,
                      width: screenSize.width / 2.4,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                          product.images[0],
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rent:  ₹${product.rent}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Deposit: ${product.deposit}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Category: ${product.roomCategory}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 120, height: 35,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditPropertyScreen(product: product,),
                                        ),
                                      );
                                    },
                                    child: Text("Edit Details", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),)),
                              ),
                              // SizedBox(width: 25),
                              // IconButton(
                              //     onPressed: () async {
                              //       await AdminServices().deletePropertyDetails(
                              //         product: product,
                              //         productUid: product.uid,
                              //       );

                              //       Utils().showSnackBar(
                              //           context: context,
                              //           content: 'property Deleted.');
                              //     },
                              //     icon: Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
