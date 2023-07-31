import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: kAccentColor),
        borderRadius: BorderRadius.circular(10),
        color: kAccentColor,

      ),
      child: Image.asset(
        imagePath,
        height: MediaQuery.of(context).size.height * 0.065,
      ),
    );
  }
}
