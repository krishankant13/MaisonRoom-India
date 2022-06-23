// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../model/multi_image_product_model.dart';
import '../utils/input_decoration.dart';

class CarouselFullScreen extends StatefulWidget {
  final Product product;
  const CarouselFullScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CarouselFullScreen> createState() => _CarouselFullScreenState();
}

class _CarouselFullScreenState extends State<CarouselFullScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87),
      body: CarouselSlider.builder(
        itemCount: widget.product.images.length,
        options: CarouselOptions(
          onPageChanged: (index, reason) =>
              setState((() => activeIndex = index)),
          height:screenSize.height,
          
          viewportFraction: 0.9,
        ),
        itemBuilder: (context, index, realIdx) {
          return Container(
            color: Colors.black,
            child: Center(
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(widget.product.images[index],
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/placeholder.png'),
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child,
                              ),
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
                              color: Colors.white,
                              value: loadingProgress.expectedTotalBytes != null
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
          );
        },
      ),
    );
  }
}
