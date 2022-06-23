import 'package:flutter/material.dart';
import 'package:maison_room/utils/input_decoration.dart';

import '../utils/color_theme.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        color: creamColor,
        width: screenSize.width/2.2,
        height: 135,
        
        child: Card( elevation: 1, color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(1.2),
            child: Image.network(
              image,
              fit: BoxFit.fill,
              width: screenSize.width/2.2,
              height: 135,
                filterQuality: FilterQuality.none,
             errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                          'assets/placeholder.png'),
                                                          frameBuilder: (context,
                                                          child,
                                                          frame,
                                                          wasSynchronouslyLoaded) =>
                                                    child,
                                                
                                               
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    widthFactor: 10,
                                                    heightFactor: 10,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                }
              
            ),
          ),
        ),
      ),
    );
  }
}
