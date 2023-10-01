import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/components/profile_page_tab.dart';
import 'package:project/components/progress_dialog.dart';
import 'package:project/components/signInButton.dart';
import 'package:project/ui/change_password.dart';

import '../components/drawer.dart';
import '../constants/colors.dart';
import '../services/signout_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void editProfilePage() async {
    await Navigator.pushNamed(context, '/editProfile');
    setState(() {});
  }
  void changePasswordPage() async {
    await Navigator.pushNamed(context, '/changePassword');
    setState(() {});
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Profile page'),
      ),
      drawer: MyDrawer(
        onHomeTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
        },
        onProfileTap: () {
          Navigator.pop(context);
          //Navigator.pushNamed(context, '/profile');
        },
        onSettingTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/settings');
        },
        onLogoutTap: signUserOut,
      ),

    // body: SafeArea(
    //   top: true,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         height: 200,
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: double.infinity,
    //               height: 140,
    //               decoration: BoxDecoration(
    //                 color: kAccentColor,
    //                 image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: Image.network(
    //                     'https://images.unsplash.com/photo-1591197172062-c718f82aba20?w=1280&h=720',
    //                   ).image,
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: AlignmentDirectional(-1, 1),
    //               child: Padding(
    //                 padding:
    //                 EdgeInsetsDirectional.fromSTEB(24, 0, 0, 16),
    //                 child: Container(
    //                   width: 90,
    //                   height: 90,
    //                   decoration: BoxDecoration(
    //                     color: kAccentColor,
    //                     shape: BoxShape.circle,
    //                     border: Border.all(
    //                       color: kPrimaryColor,
    //                       width: 2,
    //                     ),
    //                   ),
    //                   child: CircleAvatar(
    //                     radius:
    //                     MediaQuery.of(context).size.height * 0.1,
    //                     //backgroundImage: NetworkImage(profileLink),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
    //         child: Text(
    //           'name',
    //           // userData['name'],
    //           style: TextStyle(
    //             fontFamily: 'Circular',
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
    //         child: Text(
    //           currentUser.email!,
    //           style: TextStyle(
    //             fontFamily: 'Circular',
    //             fontSize: 15,
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
    //         child: Text(
    //           'Your Account',
    //           style: TextStyle(
    //             fontFamily: 'Circular',
    //             fontSize: 12,
    //           ),
    //         ),
    //       ),
    //       ProfilePageTab(
    //         onTap: editProfilePage,
    //         text: "Edit Profile",
    //         leadingIcon: Icons.account_circle_outlined,
    //         endingIcon: Icons.arrow_forward_ios,
    //       ),
    //       ProfilePageTab(
    //         onTap: editProfilePage,
    //         text: "Change Password",
    //         leadingIcon: Icons.account_circle_outlined,
    //         endingIcon: Icons.arrow_forward_ios,
    //       ),
    //       ProfilePageTab(
    //         onTap: editProfilePage,
    //         text: "Language",
    //         leadingIcon: Icons.language_outlined,
    //         endingIcon: Icons.arrow_forward_ios,
    //       ),
    //     ],
    //   ),
    // ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("userProfile")
            .doc(userUID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists)
            {
              print('in if Uid: $userUID');
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            // Fetch the 'name' and image link
            String name = userData['name'] ?? '';
            String profileLink = userData['profileLink'] ?? '';
        return SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                          'https://images.unsplash.com/photo-1591197172062-c718f82aba20?w=1280&h=720',
                        ).image,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, 1),
                    child: Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(24, 0, 0, 16),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: kAccentColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius:
                          MediaQuery.of(context).size.height * 0.1,
                          backgroundImage: NetworkImage(profileLink),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
              child: Text(
                name,
               // userData['name'],
                style: TextStyle(
                  fontFamily: 'Circular',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
              child: Text(
                currentUser.email!,
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
              child: Text(
                'Your Account',
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 12,
                ),
              ),
            ),
            ProfilePageTab(
              onTap: editProfilePage,
              text: "Edit Profile",
              leadingIcon: Icons.account_circle_outlined,
              endingIcon: Icons.arrow_forward_ios,
            ),
            ProfilePageTab(
              onTap: changePasswordPage,
              text: "Change Password",
              leadingIcon: Icons.account_circle_outlined,
              endingIcon: Icons.arrow_forward_ios,
            ),
            ProfilePageTab(
              onTap: editProfilePage,
              text: "Language",
              leadingIcon: Icons.language_outlined,
              endingIcon: Icons.arrow_forward_ios,
            ),
          ],
        ),
    );
        }
          else if (snapshot.hasError) {
            print('in else if uid: $userUID');
            return Center(
              child: Text('Error: ' + snapshot.error.toString()),
            );
          } else {
            print('in else Uid: $userUID');
            return CustomProgressDialog(message: 'Please wait'); // Return loading indicator here
          }
        },
      ),


      // body: StreamBuilder<DocumentSnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection("userProfile")
      //         .doc(currentUser.email)
      //         .snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData && snapshot.data!.exists) {
      //         print('in if');
      //         final userData = snapshot.data!.data() as Map<String, dynamic>;
      //         return SafeArea(
      //           top: true,
      //           child: Column(
      //             mainAxisSize: MainAxisSize.max,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Container(
      //                 height: 200,
      //                 child: Stack(
      //                   children: [
      //                     Container(
      //                       width: double.infinity,
      //                       height: 140,
      //                       decoration: BoxDecoration(
      //                         color: kAccentColor,
      //                         image: DecorationImage(
      //                           fit: BoxFit.cover,
      //                           image: Image.network(
      //                             'https://images.unsplash.com/photo-1591197172062-c718f82aba20?w=1280&h=720',
      //                           ).image,
      //                         ),
      //                       ),
      //                     ),
      //                     Align(
      //                       alignment: AlignmentDirectional(-1, 1),
      //                       child: Padding(
      //                         padding:
      //                             EdgeInsetsDirectional.fromSTEB(24, 0, 0, 16),
      //                         child: Container(
      //                           width: 90,
      //                           height: 90,
      //                           decoration: BoxDecoration(
      //                             color: kAccentColor,
      //                             shape: BoxShape.circle,
      //                             border: Border.all(
      //                               color: kPrimaryColor,
      //                               width: 2,
      //                             ),
      //                           ),
      //                           child: CircleAvatar(
      //                             radius:
      //                                 MediaQuery.of(context).size.height * 0.1,
      //                             backgroundImage: AssetImage(
      //                                 'lib/assets/images/avatar.png'),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
      //                 child: Text(
      //                   userData['name'],
      //                   style: TextStyle(
      //                     fontFamily: 'Circular',
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 16),
      //                 child: Text(
      //                   currentUser.email!,
      //                   style: TextStyle(
      //                     fontFamily: 'Circular',
      //                     fontSize: 15,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
      //                 child: Text(
      //                   'Your Account',
      //                   style: TextStyle(
      //                     fontFamily: 'Circular',
      //                     fontSize: 12,
      //                   ),
      //                 ),
      //               ),
      //               ProfilePageTab(
      //                 onTap: editProfilePage,
      //                 text: "Edit Profile",
      //                 leadingIcon: Icons.account_circle_outlined,
      //                 endingIcon: Icons.arrow_forward_ios,
      //               ),
      //               ProfilePageTab(
      //                 onTap: editProfilePage,
      //                 text: "Change Password",
      //                 leadingIcon: Icons.account_circle_outlined,
      //                 endingIcon: Icons.arrow_forward_ios,
      //               ),
      //               ProfilePageTab(
      //                 onTap: editProfilePage,
      //                 text: "Language",
      //                 leadingIcon: Icons.language_outlined,
      //                 endingIcon: Icons.arrow_forward_ios,
      //               ),
      //             ],
      //           ),
      //         );
      //       }
      //       else if(snapshot.hasError){
      //         print('in else if');
      //         return Center(
      //           child: Text('Error' +snapshot.error.toString(),
      //           ),
      //         );
      //       }
      //       else {
      //         print('in else');
      //         return CustomProgressDialog(message: 'Please');
      //         // Return loading indicator here
      //       }
      //
      //     },
      //
      // ),


    );
  }
}
