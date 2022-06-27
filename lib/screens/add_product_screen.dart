// ignore_for_file: sort_child_properties_last

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maison_room/components/custom_text_field.dart';
import 'package:maison_room/recources/admin_services.dart';
import 'package:maison_room/utils/input_decoration.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:maison_room/widgets/custom_main_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/utils2.dart';
import '../providers/user_details_provider.dart';
import '../utils/color_theme.dart';

class AddProductScreen extends StatefulWidget {
  // static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController maintenanceController = TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  bool isLoading = false;
  int activeIndex = 0;
  // List<File> images = [];
  final multiPicker = ImagePicker();
  List<XFile>? images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    maintenanceController.dispose();
    addressDetailsController.dispose();
    rentController.dispose();
    depositController.dispose();
  }

  String renterCategory = 'Student';
  List<String> renterTypeCategories = [
    'Student',
    'Family',
    'For Student And Family',
    'Only For Girls',
    'For Family And Girls',
    'For All'
  ];

  String roomCategory = 'Single Room';
  List<String> roomTypeCategories = [
    'Single Room',
    'Double Room',
    '1 BHK Flat',
    '2 BHK Flat',
    '3 BHK Flat'
  ];

  String cityCategory = 'Indore';
  List<String> cityTypeCategories = [
    'Indore',
    'Bhopal',
    'Vidisha',
    'Raisen',
    'Jabalpur',
    'Kota',
    'Delhi',
    'Jaipur',
    'Other'
  ];

  String furnishedLevel = 'Semi-Furnished';
  List<String> furnishedTypeLevel = [
    'Semi-Furnished',
    'Unfurnished',
    'Fully Furnished',
  ];

  String ownershipCategory = "Owner";
  var ownershipCategoryType = {
    'Owner': 'O',
    'Agent': 'A',
  };

  final List categories = [];
  countryDependentDropDown() {
    ownershipCategoryType.forEach((key, value) {
      categories.add(key);
    });
  }

  String brokerage = "";
  var brokerageAmount = {
    '₹0': 'O',
    '50% Of Rent Amount': 'A',
    '₹500': 'A',
    '₹1000': 'A',
    '₹1500': 'A',
    '₹2000': 'A',
    '₹2500': 'A',
    '₹3000': 'A',
    '₹3500': 'A',
    '₹4000': 'A',
    '₹5000': 'A',
    '₹6000': 'A',
    '₹8000': 'A',
    '₹10000': 'A',
    '₹12000': 'A'
  };

  List brokerageAmounts = [];
  stateDependentDropDown(countryShortName) {
    brokerageAmount.forEach((key, value) {
      if (countryShortName == value) {
        brokerageAmounts.add(key);
      }
    });
    brokerage = brokerageAmounts[0];
  }

  @override
  void initState() {
    super.initState();
    countryDependentDropDown();
  }

  void postProperty() {
    if (_addProductFormKey.currentState!.validate() && images!.isNotEmpty) {
      adminServices.postProperty(
        // context: context,
        maintenance: maintenanceController.text,
        addressDetails: addressDetailsController.text,
        deposit: depositController.text,
        renterCategory: renterCategory,
        roomCategory: roomCategory,
        cityCategory: cityCategory,
        furnishedLevel: furnishedLevel,
        ownershipCategory: ownershipCategory,
        brokerage: brokerage,
        images: images,
        rent: rentController.text,
        sellerName: Provider.of<UserDetailsProvider>(context, listen: false)
            .userDetails
            .name,
        sellerUid: FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res.cast<XFile>();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: darkCreamColor,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
          title: Text(
            'Post Your Property',
            style: GoogleFonts.roboto(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height / 2.5,
                    width: screenSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // getMultiImages();
                            },
                            child: GridView.builder(
                                itemCount: images!.isEmpty ? 6 : images!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                    child: images!.isEmpty
                                        ? Icon(
                                            CupertinoIcons.camera,
                                            color: Colors.grey.withOpacity(0.5),
                                          )
                                        : Image.file(
                                            File(images![index].path),
                                            fit: BoxFit.cover,
                                          ))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 2,
                      right: 2,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                          images!.length<6 ? getMultiImages():null;
                          },
                          child: images!.length<6? Row(
                            children: const [ Icon(Icons.add),
                              Text("Add Images"),
                            ],
                          ):  const Text("Limit Exceed", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)
                          ),),
                ],
              ),

          
             const Text("select Images one by one by clicking on Button", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: activeCyanColor,)),
                  const SizedBox(height: 20),
              CustomTextField(
                controller: rentController,
                labelText: 'Rent Amount Per Month',
                hintText: "Enter Rent Amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: depositController,
                labelText: 'Deposit Amount',
                hintText: 'Enter Deposit Amount',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: maintenanceController,
                labelText: 'Maintenance Charge Per Month',
                hintText: ' Enter Maintenance Charge',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Renter Type",
                        style: GoogleFonts.lato(
                            color: darkCreamColor.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            value: renterCategory,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: renterTypeCategories.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                renterCategory = newVal!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Room Type",
                        style: GoogleFonts.lato(
                            color: darkCreamColor.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: roomCategory,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: roomTypeCategories.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                roomCategory = newVal!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Furnished Level",
                        style: GoogleFonts.lato(
                            color: darkCreamColor.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: furnishedLevel,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: furnishedTypeLevel.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                furnishedLevel = newVal!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Select City",
                        style: GoogleFonts.lato(
                            color: darkCreamColor.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            isExpanded: true,
                            value: cityCategory,
                            menuMaxHeight: screenSize.height / 3,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: cityTypeCategories.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                cityCategory = newVal!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              DottedBorder(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Are You Owner or Agent ?",
                          style: GoogleFonts.lato(
                              color: darkCreamColor.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: ownershipCategory,
                            onChanged: (newValue) {
                              setState(() {
                                brokerageAmounts = [];
                                stateDependentDropDown(
                                    ownershipCategoryType[newValue]);
                                ownershipCategory = "$newValue";
                              });
                            },
                            items: categories.map((ownershipCategoryType) {
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ownershipCategoryType,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                                value: ownershipCategoryType,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Brokerage in Rupees",
                          style: GoogleFonts.lato(
                              color: darkCreamColor.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border:
                                Border.all(color: Colors.black38, width: 1)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: brokerage,
                            menuMaxHeight: screenSize.height / 3,
                            onChanged: (newValue) {
                              setState(() {
                                brokerage = "$newValue";
                              });
                            },
                            items: brokerageAmounts.map((state) {
                              return DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade700),
                                  ),
                                ),
                                value: state,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // This trailing comma makes auto-formatting nicer for build methods.

              const SizedBox(height: 10),
              TextFormField(
                controller: addressDetailsController,
                decoration: InputDecoration(
                    labelText: "Address",
                    labelStyle: GoogleFonts.lato(
                        color: darkCreamColor.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    floatingLabelStyle:
                        const TextStyle(color: Colors.blue, fontSize: 17),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Your Address",
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black38,
                    )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black38,
                    ))),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              CustomMainButtom(
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String output = await AdminServices().postProperty(
                    maintenance: maintenanceController.text,
                    addressDetails: addressDetailsController.text,
                    deposit: depositController.text,
                    furnishedLevel: furnishedLevel,
                    images: images,
                    renterCategory: renterCategory,
                    roomCategory: roomCategory,
                    cityCategory: cityCategory,
                    ownershipCategory: ownershipCategory,
                    brokerage: brokerage,
                    // rent: double.parse(rentController.text),
                    rent: rentController.text,
                    sellerName:
                        Provider.of<UserDetailsProvider>(context, listen: false)
                            .userDetails
                            .name,
                    sellerUid: FirebaseAuth.instance.currentUser!.uid,
                  );
                  if (!mounted) return;
                  setState(() {
                    isLoading = false;
                  });

                  if (output == "success") {
                    isLoading = false;
                    Utils().showSnackBar(
                        context: context, content: "Posted product");
                    // Navigator.pop(context);
                  } else {
                    Utils().showSnackBar(context: context, content: output);
                  }
                },
                color: activeCyanColor,
                child: const Text("Post Your Property"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images!.length,
        effect: const SlideEffect(
            spacing: 8.0,
            radius: 4.0,
            dotWidth: 12.0,
            dotHeight: 12.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 2,
            dotColor: Colors.white,
            activeDotColor: Colors.indigo),
      );

  Future getMultiImages() async {
    final List<XFile>? selectedImages = await multiPicker.pickMultiImage( imageQuality: 25);
    setState(() {
      if (selectedImages!.isNotEmpty) {
        images!.addAll(selectedImages);
      } else {
        print('No Images Selected ');
      }
    });
  }
}
