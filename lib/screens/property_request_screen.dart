import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/widgets/custom_main_button.dart';
import '../components/custom_text_field.dart';
import '../providers/user_details_provider.dart';
import '../recources/admin_services.dart';
import '../utils/color_theme.dart';
import '../utils/input_decoration.dart';
import '../utils/utils.dart';

class PropertyRequestScreen extends StatefulWidget {
  const PropertyRequestScreen({Key? key}) : super(key: key);

  @override
  State<PropertyRequestScreen> createState() => _PropertyRequestScreenState();
}

class _PropertyRequestScreenState extends State<PropertyRequestScreen> {
    final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
   String cityCategory = 'Indore';
  List<String> cityTypeCategory = [
    'Indore',
    'Bhopal',
    'Raisen',
    'Vidisha',
  
  ];
   String renterCategory = 'Student';
  List<String> renterTypeCategories = [
    'Student',
    'Family',
    'Girls',
    'Job person',
    'Other',
  
  ];
   String rent = "2000-3000";
  List<String> rentTypeCategory = [
    "2000-3000",
    "3000-4000",
    "4000-5000",
    "5000-6000",
    "6000-7000",
    "7000-8000",
    "8000-9000",
    "10000-15000",
    "15000-20000",
  
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(      backgroundColor: Colors.white,
                      appBar: AppBar( 
                        centerTitle: true,
                        title: Text(
                          "No Result Found!",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0.9,
                        iconTheme: const IconThemeData(color: Colors.black),
                      ),
    body:Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
           Text("Fill your requirment we will try to provides you the best property.", style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.blue.shade600),),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Select Your City",
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
                                value: cityCategory,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: cityTypeCategory.map((String item) {
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
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
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
                       
                        
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Select Your Budget Range In Rupees",
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
                                value: rent,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: rentTypeCategory.map((String item) {
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
                                    rent = newVal!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(height: 25),
                CustomTextField(
                  controller: nameController,
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: contactController,
                  labelText: 'Mobile No',
                  hintText: 'Enter Your Mobile No.',
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 25,),
                CustomTextField(
                  controller: addressController,
                  labelText: 'Address',
                  hintText: 'Enter Address',
                  maxLines: 3,
                  
                  textInputType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 15),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton(onPressed: ()async{
                 
                    String output = await AdminServices().postRequest(
                 
                      addressDetails: addressController.text,
                      renterCategory: renterCategory,
                      cityCategory: cityCategory,
                       contact: contactController.text,
                        renterName: nameController.text,
                      // rent: double.parse(rentController.text),
                      rent: rent,
                      sellerUid: FirebaseAuth.instance.currentUser!.uid,
                    );
                    if (output == "success") {
                      Utils().showSnackBar(
                          context: context, content: "Request Submitted");
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      Utils().showSnackBar(context: context, content: output);
                    }
                },
                  
                     style: 
          ElevatedButton.styleFrom(
              primary: Colors.blue,
              elevation: 4,
              fixedSize: Size(screenSize.width*0.8, 45)),
                  
                 child: const Text("Submit"))
                  ],
                )
                      ],
                    ),
                  ),
                ),
           
        ],
        ),
      ),
    )
    );
  }
}


      //  Center(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       "No Result Found!",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w600,
      //                         color: Colors.black.withOpacity(0.8),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               );