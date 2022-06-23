import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maison_room/model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../recources/admin_services.dart';

class BannnerAdWidget extends StatefulWidget {
  const BannnerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannnerAdWidget> createState() => _BannnerAdWidgetState();
}

class _BannnerAdWidgetState extends State<BannnerAdWidget> {
  List<File> images = [];
  int currentAd = 0;
  int activeIndex = 0;
  List<ImageModel>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllimage();
  }

  fetchAllimage() async {
    products = (await adminServices.fetchAllimage());
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height / 3.2,
      width: screenSize.width,

      child: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: 
                [products == null
            ? SizedBox(height: screenSize.height/3.2, width: double.infinity,)
            : Stack(
              children: 
                    [
                      CarouselSlider.builder(
                      
                      itemCount: products!.length,
                      options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlay: false,
                        onPageChanged: (index, reason) =>
                            setState((() => activeIndex = index)),
                        height: screenSize.height/3.2,
                        viewportFraction: 1,
                      ),
                      itemBuilder: (context, index, realIdx) {
                        final productData = products![index];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SizedBox(
                              width: screenSize.width,
                              height: screenSize.height/3,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(productData.images[0],
                                        errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/placeholder.png'),
                                        frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) =>
                                  child,
                                        filterQuality: FilterQuality.none,
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
                                      strokeWidth: 3,
                                      backgroundColor: Colors.blue,
                                      color:  Colors.white.withOpacity(0.75),
                                      value: loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
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
                    Positioned( left: screenSize.width/2.3, bottom: 8,
                      child: buildIndicator())
                  ],
            ),
                
              ],
      ),
    );
  }
       

     Widget buildIndicator() 
     =>products==null?  const VxShimmer(child: SizedBox(height: 10, width: 50,)): AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: products!.length,
        effect:  const SlideEffect(
            spacing: 5.0,
            radius: 4.0,
            dotWidth: 10.0,
            dotHeight: 10.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 2,
            dotColor: Colors.white,
            activeDotColor: Colors.indigo),
      );

    







  // Widget getSmallAdFromIndex(int index, double height) {
  //   return SizedBox(
  //     height: height * 0.9,
  //     child: FittedBox(
  //       child: Container(
  //         padding: const EdgeInsets.only(top: 5),
  //         height: height * 1.2,
  //         width: height * 1.2,
  //         decoration: ShapeDecoration(
  //           color: Colors.white,
  //           shadows: [
  //             BoxShadow(
  //                 color: Colors.black.withOpacity(0.2),
  //                 blurRadius: 5,
  //                 spreadRadius: 1),
  //           ],
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
