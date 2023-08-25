import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/constants/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../components/drawer.dart';
import '../services/signout_user.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  ///sign user out method


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kScaffoldBackgroundColor,
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
        onHomeTap: () {
          Navigator.pop(context);
          //Navigator.pushNamed(context, '/home');
        },
        onProfileTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/profile');
        },
        onSettingTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/settings');
        },
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
