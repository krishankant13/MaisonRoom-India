import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../model/multi_image_product_model.dart';
import '../recources/admin_services.dart';
import '../screens/property_details_screen.dart';
import '../utils/color_theme.dart';
import '../widgets/cost_widget.dart';
import '../widgets/loader.dart';
import '../widgets/single_product_widget.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({Key? key}) : super(key: key);

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: products == null
          ? const Loader()
          : Scaffold(
            appBar: AppBar( backgroundColor: backgroundColor, elevation: 1,
              title: Card( color:backgroundColor, elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                          child: Row( mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text('All Property Collections', 
                            style: TextStyle(color: Colors.black.withOpacity(0.8),
                             fontSize: 17, fontWeight: FontWeight.w500 ),),
                          ],
                                          ),
                        ),
                      ),),
           
              body: Scrollbar(
                thumbVisibility: true,
                child: PaginateFirestore(
                  
                 
                  itemBuilderType:
                      PaginateBuilderType.listView, //Change types accordingly
                  itemBuilder: (context, documentSnapshots, index) {
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
                                        builder: (context) =>
                                            PropertyDetailsScreen(
                                                product: productData),
                                      ),
                                    ),
                                    child: SingleProduct(
                                      image: productData.images[0],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RentWidget(
                                          color: Colors.black.withOpacity(0.8),
                                          rent: productData.rent),
                                      const SizedBox(height: 2),
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
                  // orderBy is compulsory to enable pagination
                  query: FirebaseFirestore.instance
                      .collection('products')
                      .orderBy('createdOn'),
                  itemsPerPage: 2,
                  // to fetch real-time data
                  isLive: true,
                ),
              ),
            ),
    );
  }
}
