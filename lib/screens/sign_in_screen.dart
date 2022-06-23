// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maison_room/layout/screen_layout.dart';
import 'package:maison_room/recources/authentication_method.dart';
import 'package:maison_room/screens/sign_up_screen.dart';
import 'package:maison_room/screens/verify_email.dart';
import 'package:maison_room/utils/utils.dart';
import 'package:maison_room/widgets/custom_main_button.dart';
import 'package:maison_room/widgets/text_fied_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/color_theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
    void loginUser() {
    context.read<AuthenticationMethods>().signInUser(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
    backgroundColor: Colors.white,
      
      body: SafeArea(
        child: SingleChildScrollView(
           

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: screenSize.height, width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Spacer(flex: 2),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(elevation: 0,
                        color:Colors.white.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Maison Room", style: GoogleFonts.roboto(color: darkCreamColor.withOpacity(0.9),
                           fontSize: 24,
                            fontWeight: FontWeight.w500,
                           
                            ),),
                        ),
                      ),

                      
                    ],
                  ),
                  Spacer(flex: 1),
               
                   Text(
                    "Sign-In",
                   style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: darkTextColor,
                  ),
                  ),
                  SizedBox(height: 28,),
                  TextFieldWidget(
                    
                    controller: emailController,
                    obscureText: false,
                    hintText: "Enter your email",
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),               
                    TextFieldWidget(
                    controller: passwordController,
                    obscureText: true,
                    hintText: "Enter your password",
                    labelText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                   SizedBox(height: 36,),
                 
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomMainButtom(
                          color: Colors.blue,
                          isLoading: isLoading,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                          
                            //future delay for showing circularindicator
                          
                            String output =
                                await authenticationMethods.signInUser(
                                    email: emailController.text,
                                    password: passwordController.text, context: context);
                          
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });
                          
                            if (output == "success") {
                              // functions
                              Utils().showSnackBar(
                                  context: context,
                                  content: 'Signin success');
                                  
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirebaseAuth.instance.currentUser!.emailVerified ?
                                          ScreenLayout():EmailVerify())
                                          );
                            } else {
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          },
                          child: const Text('Sign In')),
                    ),
                  ),
               SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: Divider(color: lightTextColor,)),
                    SizedBox(width: 16),
                    Text(
                      "New to Maison Room ?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: lightTextColor,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(child: Divider(color: lightTextColor,)),
                  ],
                ),
                SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                         
                    side: MaterialStateProperty.all(BorderSide(color: borderColor,)),
                      foregroundColor: MaterialStateProperty.all(darkTextColor),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        color: lightTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ))),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                              letterSpacing: 0.4,
                             color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ),
                  Spacer(flex: 4)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
