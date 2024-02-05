import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../../services/provider.dart';

class DiscountBanner extends StatelessWidget {
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
        //color: kScaffoldBackgroundColor,
        //borderRadius: BorderRadius.circular(20),
      ),
      child:  Text.rich(
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
    );
  }
}