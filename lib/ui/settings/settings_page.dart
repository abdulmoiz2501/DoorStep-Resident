import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/drawer.dart';
import '../../components/profile_page_tab.dart';
import '../../components/progress_dialog.dart';
import '../../constants/colors.dart';
import '../../services/signout_user.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  void editProfilePage() async {
    await Navigator.pushNamed(context, '/editProfile');
    //setState(() {});
  }

  void help() async {
    await Navigator.pushNamed(context, '/helpAndSupport');
    //setState(() {});
  }
  void terms() async {
    await Navigator.pushNamed(context, '/terms');
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: kPrimaryColor,
      ),
        drawer: MyDrawer(
          onHomeTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home');
          },
          onProfileTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/profile');
          },
          onSettingTap: () {
            Navigator.pop(context);
            //Navigator.pushNamed(context, '/settings');
          },
          onLogoutTap: signUserOut,
        ),
        body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                      child: Text(
                        'Your Settings',
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    /*ProfilePageTab(
                      onTap: editProfilePage,
                      text: "Dark Mode",
                      leadingIcon: Icons.dark_mode_outlined,
                      endingIcon: Icons.arrow_forward_ios,
                    ),*/
                    /*ProfilePageTab(
                      onTap: editProfilePage,
                      text: "Notifcations ",
                      leadingIcon: Icons.notifications_outlined,
                      endingIcon: Icons.arrow_forward_ios,
                    ),*/
                    ProfilePageTab(
                      onTap: help,
                      text: "Support",
                      leadingIcon: Icons.support_outlined,
                      endingIcon: Icons.arrow_forward_ios,
                    ),
                    ProfilePageTab(
                      onTap: terms,
                      text: "Terms of Service",
                      leadingIcon: Icons.description_outlined,
                      endingIcon: Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
    );
  }
}
