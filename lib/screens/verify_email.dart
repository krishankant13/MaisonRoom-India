import 'package:flutter/material.dart';
import 'package:maison_room/screens/sign_in_screen.dart';
import 'package:maison_room/utils/input_decoration.dart';

import '../components/custom_butoon.dart';
import '../utils/color_theme.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Verify Your Email Address First",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.8)),
                ),
                const SizedBox(height: 5),
                const Text("Check in Spam Folder"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                      width: screenSize.width / 2.5,
                      height: 40,
                      child: CustomButton(
                          onTap: () {},
                          isLoading: false,
                          child: const Text("Resend Email"))),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Note: If You already Verified Please Restart App and login again."),
                ),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text("Login Page"),
                      
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
