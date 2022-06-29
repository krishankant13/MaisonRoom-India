// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/components/utils2.dart';

import 'package:maison_room/model/multi_image_product_model.dart';
import 'package:maison_room/utils/color_theme.dart';
import 'package:maison_room/widgets/custom_main_button.dart';

import '../components/custom_text_field.dart';
import '../recources/admin_services.dart';
import '../utils/input_decoration.dart';


class EditPropertyScreen extends StatefulWidget {
  final Product product;
  const EditPropertyScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  final TextEditingController rentController = TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    rentController.dispose();
    addressDetailsController.dispose();
  }

  String availabilityStatus = 'Available';
  List<String> availabilityStatusCategory = [
    'Available',
    'Unavailable',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Your Property",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CustomTextField(
                controller: rentController,
                labelText: 'Rent Amount Per Month',
                hintText: "Enter Rent Amount",
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Room Availability Status",
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
                            value: availabilityStatus,
                            menuMaxHeight: screenSize.height / 3,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                                availabilityStatusCategory.map((String item) {
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
                                availabilityStatus = newVal!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                controller: addressDetailsController,
                labelText: 'Enter Your Address',
                hintText: "Enter Your Address",
                textInputType: TextInputType.number,
                maxLines: 3,
              ),
              const SizedBox(height: 25),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Expanded(
                  child: CustomMainButtom(
                    isLoading: isLoading,
                    onPressed: () async {
                      if (rentController.text.isNotEmpty &&
                          addressDetailsController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        await AdminServices()
                            .updatePropertyDetails(
                              addressDetails: addressDetailsController.text,
                              availabilityStatus: availabilityStatus,
                              rent: rentController.text,
                              productUid: widget.product.uid,
                              product: widget.product,
                            )
                            .then((value) => showSnackBar(
                                context, "Property Details Updated"))
                            .then((value) => Navigator.pop(context));
                        if (!mounted) return;
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        showSnackBar(context, "Please Fill All Fields");
                      }
                    },
                    color: Colors.blue,
                    child: const Text("Update Property Details"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
