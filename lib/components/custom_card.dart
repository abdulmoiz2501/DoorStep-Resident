import 'package:flutter/material.dart';

import '../constants/colors.dart';


class CustomCard extends StatelessWidget {
  final String assetImage;
  final String title;
  final VoidCallback? onTap;

  CustomCard({
    required this.assetImage,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 8.0, right: 8),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: kAccentColor.withOpacity(0.5)),
          ),
          child: ListTile(
            leading: SizedBox(
              height: 35,
              width: 35,
              child: Image.asset(assetImage),
            ),
            trailing: Wrap(
              spacing: 12,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: kPrimaryColor, // Change the color as needed
                  ),
                  onTap: onTap,
                ),
              ],
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Montserrat Medium",
                fontWeight: FontWeight.bold,
              ),
            ),
            // Add subtitle if needed
            /*subtitle: Text(
              'Your subtitle text here',
              style: TextStyle(
                fontFamily: "Montserrat Regular",
              ),
            ),*/
          ),
        ),
      ),
    );
  }
}