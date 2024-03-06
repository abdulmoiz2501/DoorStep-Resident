import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/services/login_or_register.dart';
import 'package:project/ui/onboarding/onboarding_screens.dart';
import 'package:project/ui/profile/filling_profile_details.dart';


import '../home/home_page.dart';
import '../profile/edit_profile_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in
            final user = snapshot.data!;
            // Check if user profile details are saved
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(user.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading state while checking profile details
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Error state
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else {
                  // Profile details checked
                  final userProfileData = snapshot.data!.data();
                  if (userProfileData != null) {
                    // User profile details exist, navigate to HomePage
                    //Navigator.pushReplacementNamed(context, '/home');
                    return HomePage();

                  } else {
                    // User profile details not found, navigate to EditProfilePage
                    //Navigator.pushReplacementNamed(context, '/fillProfile');
                    return FillProfilePage();

                  }
                }
              },
            );
          } else if (snapshot.hasError) {
            // Error state
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            // User is not logged in, show LoginOrRegisterPage
            //return LoginOrRegisterPage();
            return IntroductionAnimationScreen();
          }
        },
      ),
    );
  }
}
