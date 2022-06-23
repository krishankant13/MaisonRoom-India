// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Vx.cyan400,
      ),
    );
  }
}
