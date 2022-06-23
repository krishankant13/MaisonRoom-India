// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:maison_room/recources/authentication_method.dart';
import 'package:maison_room/screens/sign_in_screen.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/color_theme.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_fied_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
        
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(height: 52,),
                     Text(
                       "Welcome to Maison Room",
                       style: TextStyle(
                         color: darkTextColor.withOpacity(0.8),
                         fontWeight: FontWeight.w500,
                         fontSize: 22,
                       ),
                     ),
                    SizedBox(height: 4),
           
               SizedBox(
                height: 48,
              ),
               
                     TextFieldWidget(
                    
                       controller: nameController,
                       obscureText: false,
                       hintText: "Enter your name",
                       labelText: "Name",
                       textInputType: TextInputType.text,
                     ),
                      SizedBox(
                height: 20,
              ),
                     TextFieldWidget(
                      
                       controller: addressController,
                       obscureText: false,
                       hintText: "Enter Your Address",
                       labelText: "Address",
                       textInputType: TextInputType.streetAddress,
                     ),
                               SizedBox(
                height: 20,
              ),
                     TextFieldWidget(
                     
                       controller: phoneNumberController,
                       obscureText: false,
                       hintText: "Enter your phone number",
                       labelText: "Phone Number",
                       textInputType: TextInputType.phone,
                     ),
                               SizedBox(
                height: 20,
              ),
                     TextFieldWidget(
                  
                       controller: emailController,
                       obscureText: false,
                       hintText: "Enter your email",
                       labelText: 'Email',
                       textInputType: TextInputType.emailAddress,
                     ),
                               SizedBox(
                height: 20,
              ),
                     TextFieldWidget(     
                       controller: passwordController,
                       obscureText: true,
                       hintText: "Enter your password",
                       labelText: 'Password',
                       textInputType: TextInputType.visiblePassword,
                     ),
                               SizedBox(
                height: 20,
              ), 
                     SizedBox(height: 10),
                     Center(
                       child: SizedBox(
                        width: double.infinity,
                         child: CustomMainButtom(
                             color: Colors.blue,
                             isLoading: isLoading,
                             onPressed: () async {
                               if (!mounted) return;
                               setState(() {
                                 isLoading = true;
                               });
        
                               String output =
                                   await authenticationMethods
                                       .signUpUser(
                                           name: nameController
                                               .text,
                                           address:
                                               addressController
                                                   .text,
                                           email:
                                               emailController
                                                   .text,
                                           password:
                                               passwordController
                                                   .text,
                                           phoneNumber:
                                               phoneNumberController
                                                   .text, context: context);
        
                               setState(() {
                                 isLoading = false;
                               });
        
                               if (output == "success") {
                                 Utils().showSnackBar(
                                     context: context,
                                     content:
                                         'Signup success');
        
                                 FirebaseAuth.instance
                                     .signOut();
        
                                 // ignore: use_build_context_synchronously
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) =>
                                             SignInScreen()));
                               } else {
                                 //error
                                 Utils().showSnackBar(
                                     context: context,
                                     content: output);
                               }
                             },
                             child: const Text(
                               'Register',
                               style: TextStyle(fontSize: 14),
                             )),
                       ),
                     ),
                  SizedBox(height: 20),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "Already have an account?",
                           style: TextStyle(
                               
                               color:lightTextColor,
                               fontSize: 15,
                               fontWeight: FontWeight.w500),
                         ),
                         GestureDetector(
                           onTap: () {
                             Navigator.of(context).pushReplacement(
                               MaterialPageRoute(
                                 builder: (context) =>
                                     const SignInScreen(),
                               ),
                             );
                           },
                           child: Card(
                               elevation: 0,
                               color: Colors.white,
                               child: Padding(
                                 padding: const EdgeInsets.all(4.0),
                                 child: Text(
                                   "Login",
                                   style: TextStyle(
                                       color: Vx.blue500,
                                       fontSize: 16,
                                       fontWeight: FontWeight.w600),
                                 ),
                               )),
                         )
                       ],
                     ),
        
                    //  CustomMainButtom(
                    //      color: darkCreamColor,
                    //      isLoading: false,
                    //      onPressed: () {
                    //  Navigator.of(context).pushReplacement(
                    //      MaterialPageRoute(
                    //          builder: (context) =>
                    //              const SignInScreen()));
                    //      },
                    //      child: Text(
                    //        'Already have an account',
                    //        style: TextStyle(
                    //            letterSpacing: 0.4,
                    //            color: Colors.white,
                    //            fontWeight: FontWeight.bold,
                    //            fontSize: 16),
                    //      )),
                 
                ],
              ),
            ),
          ),
        ));
  }





    Widget getTextField({required String hint}) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          )),
    );
  }
}
