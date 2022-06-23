// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/recources/admin_services.dart';
import 'package:maison_room/screens/property_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maison_room/utils/utils.dart';

import '../utils/color_theme.dart';
import '../utils/input_decoration.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;

  const CartItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: SizedBox(
        child: Card(
          elevation: 1,
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "City: ${product.cityCategory}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "Rent: ₹${product.rent}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Container( color: Colors.black,
                    width: screensize.width,
                    height: screensize.height * 0.3,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(product.images[0],
                          filterQuality: FilterQuality.none,
                          
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/placeholder.png'),
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) =>
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: child,
                                  ),
                          width: screenSize.width,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              widthFactor: 10,
                              heightFactor: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor: Colors.blue,
                                  color: Colors.white,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Card(
                elevation: 0,
                color: creamColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text("Remove"),
                            IconButton(
                                onPressed: () async {
                                  AdminServices()
                                      .deleteProductFromCart(uid: product.uid);
                                },
                                icon: Icon(CupertinoIcons.delete)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PropertyDetailsScreen(
                                    product: product,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            'More Details',
                            style: TextStyle(color: activeCyanColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
