// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:maison_room/recources/admin_services.dart';
import 'package:maison_room/widgets/banner_ad_widget.dart';
import 'package:maison_room/widgets/categories_horizontal_list_view_bar.dart';
import 'package:maison_room/widgets/product_showcase_list_view.dart';
import 'package:maison_room/widgets/search_bar_widget.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  // double offset = 0;
  List<Widget>? student;
  List<Widget>? family;
  List<Widget>? hostel;
  List<Widget>? all;





  

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> category1 =
        await AdminServices().getProductsFromCategory("Student");
    List<Widget> category2 =
        await AdminServices().getProductsFromCategory("Family");
    List<Widget> category4 =
        await AdminServices().getProductsFromCategory("For All");

    if (!mounted) return;
    setState(() {
      student = category1;
      family = category2;
      all = category4;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height / 3;
    double titleHeight = 25;
    
  
    return Scaffold(
      
      backgroundColor:Colors.grey.shade100 ,
      // appBar: SearchBarWidget(
        
      //   isReadOnly: true,
      //   hasBackButton: false,
      // ),
      body: SafeArea(
        child: student != null && family != null  && all!=null
            ? Stack(
                children: [
                  RefreshIndicator(
                    edgeOffset: 20,
                    displacement: 40,
                    backgroundColor: Colors.grey.shade200,
                    onRefresh: () {
                      return 
                      Future.delayed(const Duration(seconds: 1));
                    },
                    child:
                     SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: [
                           SearchBarWidget(hasBackButton: false, isReadOnly: true,
                          ),
                          // const Divider(height: 1),
                          // const SizedBox(height: 0),
                             
                          //  const CategoriesHorizontalListViewBar(),
                           const BannnerAdWidget(),
                            // const Divider(height: 1),
                          const CategoriesHorizontalListViewBar(),
                          //  const Divider(height: 1),
                          ProductShowCaseListView(
                              title: "For Student", query: 'Student',
                              children: student!),
                          // const Divider(height: 1, thickness: 1),
                          ProductShowCaseListView(
                              title: "For Family", query: 'Family',
                              children: family!),
                          // const Divider(height: 1, thickness: 1),
                          // const Divider(height: 1, thickness: 1),
                          ProductShowCaseListView(
                              title: "For All", query: 'For All',
                              children: all!),


                        ],
                      ),
                    ),
                  ),
                ],
              )
            :
            //  const LoadingWidget(),
            // shimmer Effect
            ListView(
                shrinkWrap: true,
                children: [
                  SearchBarWidget(isReadOnly: true, hasBackButton: false),
                  SizedBox(
                    width: double.infinity,
                    height: screenSize.height / 4,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.25),
                        highlightColor: Colors.white.withOpacity(0.75),
                        direction: ShimmerDirection.ltr,
                        period: const Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                          width: double.infinity,
                          height: screenSize.height / 4,
                        )),
                  ),
                  Container(
                    height: kAppBarHeight * 0.5,
                    width: double.infinity,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.25),
                          highlightColor: Colors.white.withOpacity(0.75),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            width: 1, color: Colors.teal),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Center(
                                          child: Text(
                                            categoriesList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    height: height * 1.1,
                    width: screenSize.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: titleHeight,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                              ),
                              const Text(
                                "Show more",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height / 4,
                          width: screenSize.width,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: SizedBox(
                              height: height - (titleHeight + 20),
                              width: screenSize.width,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.25),
                                highlightColor: Colors.white.withOpacity(0.75),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      width: screenSize.width / 2,
                                      height: screenSize.height / 4,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: screenSize.width / 2,
                                      height: screenSize.height / 4,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}











// pagination code

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // List<DocumentSnapshot> _products = [];
  // bool isLoading = true;

  // _getProducts() async {
  //   Query query =
  //       firestore.collection("products").orderBy("sellerName").limit(4);

  //   isLoading = true;
  //   QuerySnapshot querySnapshot = await query.get();
  //   _products = querySnapshot.docs;
  //   isLoading = false;
  // }
