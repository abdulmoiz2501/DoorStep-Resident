import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/constants/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../components/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  ///sign user out method
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: () {},
        onSettingTap: () {},
        onLogoutTap: signUserOut,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Logged In as ${user.email!}'),
          ),
        ],
      ),
    );
  }
}
