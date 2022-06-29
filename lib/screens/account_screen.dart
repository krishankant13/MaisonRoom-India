// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/model/order_request_model.dart';
import 'package:maison_room/profile/profile_page_one.dart';
import 'package:maison_room/profile/renter_profile_page.dart';
import 'package:maison_room/utils/constants.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_details_model.dart';
import '../utils/color_theme.dart';
import '../widgets/my_order_widget.dart';
import '../widgets/simple_product_widget.dart';
import 'add_product_screen.dart';
import '../providers/user_details_provider.dart';
import 'sign_in_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  MaterialStateProperty<Size?>? materialStateProperty;
  @override

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: creamColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: darkCreamColor),
          backgroundColor: creamColor,
          elevation: 0.2,
          title: Text(
            "Maison Room",
            style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: darkCreamColor.withOpacity(0.9)),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePageOne(),
                ),
              );
            },
          ),
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            primary: Colors.blueGrey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width * 0.08),
                                child: Text(
                                  'Sign out',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                        
                     FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false),
                    },
                  );
                            
                            
                        
                          },
                        ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            primary: Color.fromARGB(255, 0, 120, 210),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: Colors.white.withOpacity(0.9),
                                size: 25,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Post Property',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductScreen(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                FutureBuilder (
                    future:  FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orders")
                        .limit(4)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else  {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          Product product = Product.getModelFromJson(
                              json: snapshot.data!.docs[i].data());

                          children.add(SimpleProductWidget(product: product));
                        }
                        return OrderShowCaseListView(
                            title: "Request Send", children: children);
                      }
                    }),
                Row( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Room Request',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orderRequests")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return SizedBox(
                          child: snapshot.data!.docs.isNotEmpty? ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                OrderRequestModel model =
                                    OrderRequestModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RenterProfilePage(
                                          orderRequestModel: model,
                                        ),
                                      ),
                                    );
                                  },
                                  child:  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: ListTile(
                                          title: Text(
                                            'Order:${model.name}',
                                          ),
                                          subtitle: Text(
                                              'Contact: ${model.phoneNumber}'),
                                          leading: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RenterProfilePage(
                                                      orderRequestModel: model,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                CupertinoIcons.eye,
                                                color: Colors.blue,
                                              )),
                                          trailing: IconButton(
                                              onPressed: () async {
                                                FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection("orderRequests")
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    Colors.red.withOpacity(0.8),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                          ):  SizedBox( height: screenSize.height/3.5, width: double.infinity,
                            child: const Center(child: Text("No request recieved", 
                            style: TextStyle(
                              fontWeight: FontWeight.w400, 
                              fontSize: 15),),),
                          )
                        );
                      }
                    },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 3,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: darkCreamColor, blurRadius: 1)],
          color: creamColor),
      child: Container(
        height: kAppBarHeight / 2.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, creamColor],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello,  ',
                      style: TextStyle(color: Colors.grey[800], fontSize: 17),
                    ),
                    TextSpan(
                      text: " ${userDetails.name}",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
         
          ],
        ),
      ),
    );
  }
}








