import 'package:flutter/material.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/constants/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final GlobalKey<State> containerKey; // Use GlobalKey<State> with nullable type

  RoundedInputField({
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required Key? key, // Make the key nullable
  })  : containerKey = GlobalKey<State>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      key: containerKey,
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
