import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:project/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../../../services/provider.dart';

class DiscountBanner extends StatelessWidget {
  _callNumber(String number) async{
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userName = Provider.of<UserData>(context).userName;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: kScaffoldBackgroundColor,
        //borderRadius: BorderRadius.circular(20),
      ),
      child:  Row(
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "Hey, $userName!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(), // Add Spacer to push AvatarGlow to the end
          AvatarGlow(
            glowColor: kAccentColor4,
            glowRadiusFactor: 0.7,
            duration: Duration(milliseconds: 1700),
            repeat: true,
            animate: true,
            glowShape: BoxShape.circle,
            child: MaterialButton(
              elevation: 3,
              onPressed: () => _callNumber('15'),
              color: kAccentColor,
              textColor: Colors.white,
              child: Text(
                'SOS',
                style: TextStyle(fontSize: 12),
              ),
              padding: EdgeInsets.all(2),
              shape: CircleBorder(),
            ),
          ),
        ],
      )

    );
  }
}