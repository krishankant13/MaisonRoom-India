import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maison_room/model/image_model.dart';
import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/model/property_request_model.dart';
import 'package:maison_room/profile/profile_user_model.dart';
import '../model/review_model.dart';
import '../model/user_details_model.dart';
import '../myPost/my_post_single_property.dart';
import '../utils/utils.dart';
import '../widgets/simple_product_widget.dart';

class AdminServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future uploadNameAndAddressAndEmailToDatabase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .doc(firebaseAuth.currentUser!.uid)
        .set(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    Product product =
        Product.getModelFromJson(json: (snapshot.data() as dynamic));
    int currentRating = product.rating;
    int newRating = (currentRating + reviewModel.rating) ~/ 2;
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }

  Future addProductToOrders(
      {required Product product, required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(product.getJson());
    await sendOrderRequest(product: product, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required Product product, required UserDetailsModel userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(product.sellerUid)
        .collection("orderRequests")
        .add(userDetails.getJson());
  }

  // // Accept product for request
  // Future acceptProductToOrders(
  //     {required Product product, required UserDetailsModel userDetails}) async {
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection("accept request")
  //       .add(product.getJson());
  //   await sendAcceptRequest(product: product, userDetails: userDetails);
  // }

  // Future sendAcceptRequest(
  //     {required Product product, required UserDetailsModel userDetails}) async {
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(product.sellerUid)
  //       .collection("orderRequests")
  //       .add(userDetails.getJson());
  // }


  Future addProductToCart({required Product product}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(product.uid)
        .set(product.getJson());
  }

  Future deletePropertyDetails(
      {required Product product, required String productUid}) async {
    await firebaseFirestore.collection("products").doc(productUid).delete();
  }

  Future updatePropertyDetails(
      {required Product product, required String productUid, required String addressDetails, required String availabilityStatus, required String rent}) async {
    await firebaseFirestore.collection("products").doc(productUid).update({"addressDetails":addressDetails, "availabilityStatus":availabilityStatus,"rent":rent});
  }

  Future getNameAndAddressAndEmail() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  Future getUserProfileDetails() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserprofileModel userprofileModel = UserprofileModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userprofileModel;
  }

  // postProducts List

  Future<String> postProperty({
    // required BuildContext context,
    required String maintenance,
    required String addressDetails,
    required String rent,
    required String deposit,
    required String availabilityStatus,
    required String renterCategory,
    required String roomCategory,
    required String cityCategory,
    required String furnishedLevel,
    required String ownershipCategory,
    required String brokerage,
    required List<XFile>? images,
    required String sellerName,
    required String sellerUid,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // ignore: unused_local_variable
    String output = "Something went wrong";
    // ignore: unrelated_type_equality_checks
    if (images != "" && maintenance != "" && rent != "") {
      try {
        String uid = Utils().getUid();

        final cloudinary = CloudinaryPublic('dolrrqlsf', 'ixjs8wx0');
        List<String> imageUrls = [];

        for (int i = 0; i < images!.length; i++) {
          CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: sellerName),
          );
          imageUrls.add(res.secureUrl);
        }

        Product product = Product(
          maintenance: maintenance,
          createdOn:Timestamp.now(),
          addressDetails: addressDetails,
          deposit: deposit,
          images: imageUrls,
          renterCategory: renterCategory,
          roomCategory: roomCategory,
          cityCategory: cityCategory,
          furnishedLevel: furnishedLevel,
          availabilityStatus:availabilityStatus,
          ownershipCategory: ownershipCategory,
          brokerage: brokerage,
          rent: rent,
          uid: uid,
          sellerName: sellerName,
          sellerUid: sellerUid,
          rating: 5,
          noOfRating: 0,
        );
        await FirebaseFirestore.instance
            .collection("products")
            .doc(uid)
            .set(product.getJson());

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }
    return output;
  }
  Future<String> postRequest({
    // required BuildContext context,
    required String addressDetails,
    required String rent,
    required String renterCategory,
    required String cityCategory,
    required String renterName,
    required String sellerUid,
    required String contact,
    required String roomCategory,
  }) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // ignore: unused_local_variable
    String output = "Something went wrong";
    // ignore: unrelated_type_equality_checks
    if ( contact!= "" && renterName != "" && rent != "") {
      try {
        String uid = Utils().getUid();

        PropertyRequestModel propertyRequestModel = PropertyRequestModel(
          addressDetails: addressDetails,
          cityCategory: cityCategory,
          rent: rent,
          contact: contact,
          renterCategory: renterCategory,
          sellerUid: sellerUid,
          renterName: renterName, 
          roomCategory:roomCategory,
        );
        await FirebaseFirestore.instance
            .collection("property requests")
            .doc()
            .set(propertyRequestModel.getJson());

        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }
    return output;
  }

  // Fetched Products
  
  Future<List<Product>> fetchAllProducts(context) async {
    List<Product> productList = [];
    QuerySnapshot<Map<String, dynamic>> snap =
        await firebaseFirestore.collection("products").get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      Product product =
          Product.getModelFromJson(json: (docSnap.data() as dynamic));
      productList.add(product);
    } 
    return productList;
  }
     








  Future<List<ImageModel>> fetchAllimage() async {
    List<ImageModel> imageList = [];
    QuerySnapshot<Map<String, dynamic>> snap =
        await firebaseFirestore.collection("my ads").get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ImageModel imageModel =
          ImageModel.getModelFromJson(json: (docSnap.data() as dynamic));
      imageList.add(imageModel);
    }
    return imageList;
  }

  Future<List<Widget>> getProductsFromCategory(String renterCategory) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("renterCategory", isEqualTo: renterCategory)
        .limit(4)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      Product product =
          Product.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SimpleProductWidget(product: product));
    }
    return children;
  }

  Future<List<Widget>> getProductsFromSellerUid(sellerUid) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("sellerUid", isEqualTo: sellerUid)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      Product product =
          Product.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(MyPostSingleProperty(product: product));
    }
    return children;
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      Product product = Product.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrders(product: product, userDetails: userDetails);
      await deleteProductFromCart(uid: product.uid);
    }
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }
}
