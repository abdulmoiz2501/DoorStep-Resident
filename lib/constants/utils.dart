import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No Images Selected');
}
class FirebaseService {
  Future<String> fetchProfileLink(String uid) async {
    try {
      DocumentSnapshot userProfileSnapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(uid)
          .get();

      if (userProfileSnapshot.exists) {
        return userProfileSnapshot['profileLink'] ?? ''; // Return profile link or empty string if not available
      } else {
        return ''; // Document doesn't exist, return empty string
      }
    } catch (e) {
      print('Error fetching profile link: $e');
      return ''; // Return empty string in case of error
    }
  }
}