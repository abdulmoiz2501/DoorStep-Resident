import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfilePageTab extends StatelessWidget {
  final IconData leadingIcon;
  final IconData endingIcon;
  final Function()? onTap;
  final String text;

  const ProfilePageTab({super.key, required this.onTap, required this.text, required this.leadingIcon, required this.endingIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
        child: Material(
          color: Colors.transparent,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    //,
                    leadingIcon,
                    color: kTextColor,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.9, 0),
                      child: Icon(
                        endingIcon,
                        //Icons.arrow_forward_ios,
                        color: kTextColor,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
