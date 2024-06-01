
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/constants/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../chat/Chat.dart';
import '../../components/drawer.dart';
import '../../services/signout_user.dart';
import 'components/banner.dart';
import 'components/categories.dart';
import 'components/special_offers.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  ///sign user out method




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kAccentColor3,
      appBar: AppBar(
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
        onComplaintsTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/complaints_status');
        },
        onSettingTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/settings');
        },
        onAdminChatTap: () {
            Navigator.push(context,new MaterialPageRoute(builder: (context) => Chat( peerId: 'CJj1lkcicIXJ2WKIx71fM9nRiJU2'.toString(),type: 'resident',)));
          },

        onLogoutTap: signUserOut,
      ),

       body: SafeArea(
         child: SingleChildScrollView(
           padding: EdgeInsets.symmetric(vertical: 4),
           child: Column(
             children: [
               DiscountBanner(),
               Categories(),
               SpecialOffers(),
               SizedBox(height: 20),
               //Payment?
               //Doorstep homes

             ],
           ),
         ),
       ),
      //
    );
  }
}

