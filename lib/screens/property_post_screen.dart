// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/recources/admin_services.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/screens/property_details_screen.dart';
import 'package:maison_room/widgets/cost_widget.dart';
import 'package:maison_room/widgets/single_product_widget.dart';
import 'package:maison_room/widgets/loader.dart';

import '../profile/profile_page_one.dart';
import '../utils/color_theme.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }
  

  fetchAllProducts() async {
    products = (await adminServices.fetchAllProducts(context));
    if (!mounted) return;
    setState(() {});
  }

  void navigateToAddProduct() {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: products == null
          ? const Loader()
          : Scaffold(
            backgroundColor: creamColor,
              appBar: AppBar(
                title: Text(
                  "Rental Property Collections",
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkCreamColor.withOpacity(0.9)),
                ),
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
                backgroundColor: creamColor,
                elevation: 0.2,
              ),
              body: RefreshIndicator(
                edgeOffset: 20,
                displacement: 40,
                backgroundColor: darkCreamColor,
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    final productData = products![index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PropertyDetailsScreen(
                                        product: productData),
                                  ),
                                ),
                                child: SingleProduct(
                                  image: productData.images[0],
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RentWidget(
                                      color: Colors.black.withOpacity(0.8),
                                      rent: productData.rent),
                                  SizedBox(height: 2),
                                  Text(
                                    "City: ${productData.cityCategory}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.8)),
                                  ),
                                  Text(
                                    "Owner:\n${productData.sellerName}",
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
                                            PropertyDetailsScreen(
                                                product: productData),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
