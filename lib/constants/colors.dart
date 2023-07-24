import 'package:flutter/material.dart';


const kPrimaryColor =  Color(0xFF8814CC);
const kPrimaryLightColor = Color(0xFFF7ECFE);
const kAccentColor = Color(0xFF1811A7);
const kWhite = Colors.white;
const kTextBoxColor = Color(0xFFF9F1FE);
const kHintTextColor = Color(0xFF8C8C8C);

class MyColors {
  static Map<int, Color> grey = {
    500: Color(0xFF666666),
  };
}
Color getColorFromIndex(Map<int, Color> colorMap, int index) {
  return colorMap[index] ?? Colors.black; // Return default black if the index is not found
}

final Color kTextColor = getColorFromIndex(MyColors.grey, 500);
