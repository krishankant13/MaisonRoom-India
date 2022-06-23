// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/screens/review_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/utils/input_decoration.dart';
import '../providers/user_details_provider.dart';
import '../recources/admin_services.dart';
import '../utils/color_theme.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/review_dialog.dart';
import 'carousel_full_screen.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Product product;

  PropertyDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  int activeIndex = 0;

  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor.withOpacity(0.8),
      bottomSheet: Card(
        elevation: 0,
        color: creamColor.withOpacity(0.8),
        child: BottomAppBar(
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomMainButtom(
                        color: Colors.blue.shade700,
                        isLoading: false,
                        onPressed: () {
                          AdminServices().addProductToOrders(
                              product: widget.product,
                              userDetails: Provider.of<UserDetailsProvider>(
                                      context,
                                      listen: false)
                                  .userDetails);

                          // show snackbar.

                          Utils().showSnackBar(
                              context: context, content: "Order Placed");
                        },
                        child: Text(
                          "Contact Now",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.9),
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(width: 20),
                    CustomMainButtom(
                        color: darkCreamColor,
                        isLoading: false,
                        onPressed: () async {
                          //Add productModelToDatabase

                          await AdminServices()
                              .addProductToCart(product: widget.product);

                          Utils().showSnackBar(
                              context: context, content: 'Added to Cart.');
                        },
                        child: Text(
                          "Save for later",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.9),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: darkCreamColor,
        title: Text(
          "Rental Property Details",
          style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            color: creamColor.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: creamColor.withOpacity(0.8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CarouselFullScreen(product: widget.product),
                              ),
                            );
                          },
                          child: Card(
                            color: creamColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: widget.product.images.length,
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState((() => activeIndex = index)),
                                      height: 280,
                                      viewportFraction: 1,
                                    ),
                                    itemBuilder: (context, index, realIdx) {
                                      return Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: SizedBox(
                                            width: screenSize.width,
                                            height: 280,
                                            child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: Image.network(
                                                  widget.product.images[index],
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                          'assets/placeholder.png'),
                                                  frameBuilder: (context,
                                                          child,
                                                          frame,
                                                          wasSynchronouslyLoaded) =>
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: child,
                                                      ),
                                                  filterQuality:
                                                      FilterQuality.none,
                                                  width: screenSize.width,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      widthFactor: 10,
                                                      heightFactor: 10,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 3,
                                                          backgroundColor:
                                                              Colors.blue,
                                                          color: Colors.white,
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  buildIndicator(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewListScreen(
                                                    product: widget.product),
                                          ),
                                        ),
                                        child: Card(
                                          color: creamColor.withOpacity(0.8),
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 2,
                                                bottom: 2,
                                                right: 5),
                                            child: Text(
                                              "Show Reviews",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        color: creamColor.withOpacity(0.8),
                                        elevation: 0,
                                        shadowColor: Colors.yellowAccent,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ReviewDialog(
                                                        productUid:
                                                            widget.product.uid,
                                                      ));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Add Reviews",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.blue),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          ReviewDialog(
                                                        productUid:
                                                            widget.product.uid,
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                      CupertinoIcons.star,
                                                      size: 20,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: creamColor.withOpacity(0.8),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "Rent: ₹${widget.product.rent}",
                                  style: GoogleFonts.lato(
                                    color: Vx.black.withOpacity(0.7),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Center(
                                child: Card(
                                    color: Colors.grey.shade500,
                                    child: SizedBox(
                                      width: 1,
                                      height: 28,
                                    )),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "Deposit:₹${widget.product.deposit}",
                                  style: GoogleFonts.lato(
                                    color: Vx.black.withOpacity(0.7),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: creamColor.withOpacity(0.8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "About Property",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Table(
                                    defaultColumnWidth:
                                        const FlexColumnWidth(1),
                                    border: TableBorder.all(
                                        color: Colors.black.withOpacity(0.6),
                                        style: BorderStyle.solid,
                                        width: 1),
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Room Type:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${widget.product.roomCategory}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "City:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${widget.product.cityCategory}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Maintenance:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  " ₹${widget.product.maintenance}",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 15,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Renter Type:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${widget.product.renterCategory}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Room Type:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "  ${widget.product.roomCategory}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${widget.product.ownershipCategory}:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${widget.product.sellerName}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Brokerage:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "  ${widget.product.brokerage}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Furnished Type:",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${widget.product.furnishedLevel}",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address",
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        widget.product.addressDetails,
                                        style: TextStyle(
                                          color: Vx.black.withOpacity(0.7),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.product.images.length,
        effect: SlideEffect(
            spacing: 8.0,
            radius: 4.0,
            dotWidth: 12.0,
            dotHeight: 12.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 1.5,
            dotColor: Colors.grey,
            activeDotColor: Colors.indigo),
      );
}
