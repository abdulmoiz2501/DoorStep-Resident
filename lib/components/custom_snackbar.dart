import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void showSosSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black87,
      content: AwesomeSnackbarContent(
        title: 'SOS Notified',
        message: 'Help is on the way!',
        contentType: ContentType.success,
        color: Colors.redAccent,
      ),
      duration: Duration(seconds: 3),
    ),
  );
}

