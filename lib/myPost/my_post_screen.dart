import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../recources/admin_services.dart';
import '../utils/color_theme.dart';
import '../widgets/loading_widget.dart';
import 'mypost_property_details.dart';


class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
   ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? mypost;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {

    List<Widget> myPost =
      await AdminServices().getProductsFromSellerUid(FirebaseAuth.instance.currentUser!.uid);
    if (!mounted) return;
    setState(() {
      mypost = myPost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("My Post"),),
        body: mypost!=null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: MyPostPropertyDetails(
                        title: "My Post", children: mypost!),
                  ),
               
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
