// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class RatingStarWidget extends StatelessWidget {
  final int rating;

  const RatingStarWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < 5; i++) {
      children.add(i < rating
          ? Icon(Icons.star, color: Colors.orange,size: 15,)
          : Icon(
              Icons.star_border,
              color: Colors.orange,
              size: 15,
            ));
    }

    return Row(children:children);
  }
}
