import 'package:flutter/material.dart';

import '../constants/colors.dart';
class SignInButton extends StatelessWidget {


  final Function()? onTap;

  const SignInButton({super.key, this.onTap});




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.065),
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.066),
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.045),
        ),
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: kPrimaryLightColor,
              fontSize: MediaQuery.of(context).size.height * 0.024,
              fontWeight: FontWeight.bold,
              //fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}
