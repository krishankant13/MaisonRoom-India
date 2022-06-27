// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:maison_room/layout/screen_layout.dart';
import 'package:maison_room/providers/user_details_provider.dart';
import 'package:maison_room/screens/sign_in_screen.dart';
import 'package:maison_room/screens/verify_email.dart';
import 'package:maison_room/utils/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "",
            authDomain: "",
            projectId: "",
            storageBucket: "",
            messagingSenderId: "",
            appId: ""));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MaisonRoom());
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: Center(
          child: Text("Something Went Wrong!"),
        ),
      );
}

class MaisonRoom extends StatelessWidget {
  const MaisonRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        title: "Maison Room",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: backgroundColor),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } 
              
              // else if (user.hasData && !FirebaseAuth.instance.currentUser!.emailVerified) {
                
              //   return AnimatedSplashScreen(
              //       centered: true,
              //       splashTransition: SplashTransition.fadeTransition,
              //       splash: Center(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             const Icon(
              //               Icons.search,
              //               color: activeCyanColor,
              //               size: 30,
              //             ),
              //             Text(
              //               "Maison Room",
              //               style: TextStyle(
              //                   fontSize: 26,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black.withOpacity(0.85)),
              //             )
              //           ],
              //         ),
              //       ),
              //       nextScreen: const EmailVerify());
              // } 
              else if (user.hasData && user.requireData!.emailVerified ){
                return  AnimatedSplashScreen(
                    centered: true,
                    splashTransition: SplashTransition.fadeTransition,
                    splash: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home,
                            color: activeCyanColor,
                            size: 30,
                          ),
                          Text(
                            "Maison Room",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.85)),
                          )
                        ],
                      ),
                    ),
                    nextScreen: const ScreenLayout());
              }
              
              
               else if (user.hasError) {
                return AnimatedSplashScreen(
                    centered: true,
                    duration: 500,
                    splashTransition: SplashTransition.fadeTransition,
                    splash: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home,
                            color: activeCyanColor,
                            size: 30,
                          ),
                          Text(
                            "Maison Room",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.85)),
                          )
                        ],
                      ),
                    ),
                    nextScreen: const SignInScreen());
              } else {
                return AnimatedSplashScreen(
                    centered: true,
                    duration: 500,
                    splashTransition: SplashTransition.fadeTransition,
                    splash: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.home,
                            color: activeCyanColor,
                            size: 30,
                          ),
                          Text(
                            "Maison Room",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.85)),
                          )
                        ],
                      ),
                    ),
                    nextScreen: const SignInScreen());
              }
            }),
      ),
    );
  }
}
