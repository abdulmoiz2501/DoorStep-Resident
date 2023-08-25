import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/components/my_list_tile.dart';
import 'package:project/constants/colors.dart';

import '../constants/utils.dart';

class MyDrawer extends StatefulWidget {

  final void Function()? onHomeTap;
  final void Function()? onProfileTap;
  final void Function()? onSettingTap;
  final void Function()? onLogoutTap;

  const MyDrawer({Key? key, required this.onProfileTap, required this.onSettingTap, required this.onLogoutTap, required this.onHomeTap}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: kPrimaryColor,
      child: Column(
        children: [
         SizedBox(height: 50,),
          //header
    //   DrawerHeader(
    //   child: FutureBuilder<String>(
    //     future: profileLinkFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         // Return a loading indicator or placeholder if fetching is still in progress
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasError) {
    //         // Handle error if fetching fails
    //         return Text('Error fetching profile link');
    //       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
    //         // Use the fetched profile link if available
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundImage: NetworkImage(snapshot.data!),
    //         );
    //       } else {
    //         // Fallback to a default avatar image if no profile link available
    //         return CircleAvatar(
    //           radius: 50,
    //           backgroundImage: AssetImage('lib/assets/images/avatar.png'),
    //         );
    //       }
    //     },
    //   ),
    // ),

         ///home list tile
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: widget.onHomeTap,
          ),
          ///profile list tile
          MyListTile(
              icon: Icons.person,
              text: 'P R O F I L E' ,
              onTap: widget.onProfileTap
          ),

          ///settings list tile
          MyListTile(
              icon: Icons.settings,
              text: 'S E T T I N G S' ,
              onTap: widget.onSettingTap,
          ),

          ///logout list tile
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: widget.onLogoutTap,
          ),
        ],
      ),
      //   child: Column(
      //     children: [
      //       const UserAccountsDrawerHeader(
      //         accountName: Text('User Name'),
      //         accountEmail: Text(''),
      // ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Home'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Profile'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.settings),
      //         title: const Text('Settings'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.logout),
      //         title: const Text('Logout'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
    );
  }
}
