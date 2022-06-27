// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/utils/input_decoration.dart';
import '../screens/property_details_screen.dart';
import '../utils/color_theme.dart';

class SimpleProductWidget extends StatefulWidget {
  final Product product;

  const SimpleProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SimpleProductWidget> createState() => _SimpleProductWidgetState();
}

class _SimpleProductWidgetState extends State<SimpleProductWidget> {
  


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        color: Colors.grey.withOpacity(0.8),
        child: Card(
          color: Colors.grey.shade100,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2, right: 2, top: 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: screenSize.height / 6,
                      width: screenSize.width / 2.1,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        // child: FadeInImage.memoryNetwork(
                        //   imageErrorBuilder: (context, error, stackTrace) =>  Image.asset('assets/placeholder.png'),
                        //   placeholder: kTransparentImage,
                        //   image: product.images[0],
                        // ),
                       child:  Image.network(widget.product.images[0],
                     errorBuilder: (context, error, stackTrace) => Image.asset('assets/placeholder.png'),
                     frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => Padding(
                     padding: const EdgeInsets.all(8.0),
                        child: child,
                      ),
                       ),
                      ),),
                  Text(
                    "Rent:  ₹${widget.product.rent}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: darkCreamColor),
                  ),
                  Text(
                    "City: ${widget.product.cityCategory}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                 style: GoogleFonts.roboto(fontSize: 11,letterSpacing: 0.6, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                  ),
                  Text(
                    "Category: ${widget.product.roomCategory}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                     style: GoogleFonts.roboto(fontSize: 11,letterSpacing: 0.6, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
