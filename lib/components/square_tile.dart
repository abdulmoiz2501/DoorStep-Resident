import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: kAccentColor),
          borderRadius: BorderRadius.circular(10),
          color: kAccentColor,

        ),
        child: Image.asset(
          imagePath,
          height: MediaQuery.of(context).size.height * 0.045,
        ),
      ),
    );
  }
}
