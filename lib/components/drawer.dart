import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/components/my_list_tile.dart';
import 'package:project/constants/colors.dart';

class MyDrawer extends StatelessWidget {

  final void Function()? onHomeTap;
  final void Function()? onProfileTap;
  final void Function()? onSettingTap;
  final void Function()? onLogoutTap;

  const MyDrawer({Key? key, required this.onProfileTap, required this.onSettingTap, required this.onLogoutTap, required this.onHomeTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    return Drawer(
      backgroundColor: kPrimaryColor,
      child: Column(
        children: [
          //header
          DrawerHeader(
            child: CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),

         ///home list tile
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: onHomeTap,
          ),
          ///profile list tile
          MyListTile(
              icon: Icons.person,
              text: 'P R O F I L E' ,
              onTap: onProfileTap
          ),

          ///settings list tile
          MyListTile(
              icon: Icons.settings,
              text: 'S E T T I N G S' ,
              onTap: onSettingTap,
          ),

          ///logout list tile
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: onLogoutTap,
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
