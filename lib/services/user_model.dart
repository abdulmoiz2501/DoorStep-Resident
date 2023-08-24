import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference userDetails = FirebaseFirestore.instance.collection('User Details');
String userUID = FirebaseAuth.instance.currentUser!.uid;
final currentUser = FirebaseAuth.instance.currentUser!;


class StoreData{

  Future<String> uploadProfileImageToStorage(String name, Uint8List image) async{
    String imageUrl = '';
    try{
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      Reference ref = storage.ref().child('profileImages/$name/$fileName');
      UploadTask uploadTask = ref.putData(image);
      await uploadTask.whenComplete(() async{
        imageUrl = await ref.getDownloadURL();
      });
    }
    catch(err){
      print(err);
    }
    return imageUrl;
  }


  Future<String> saveUserProfileData ({
    required String name,
    required String phone,
    required Uint8List file,
  }) async {
    String resp = " Some Error Occurred";
    try{
      if(name.isNotEmpty || phone.isNotEmpty) {
        String imageUrl = await uploadProfileImageToStorage('profileImage', file);
        await _firestore.collection('userProfile').doc(userUID)
            .set({
          'uid': userUID,
          'email': currentUser.email,
          'name': name,
          'phone': phone,
          'profileLink': imageUrl,
          'usertype' : 'resident',
        });

        resp = 'success';
      }
    }
    catch(err){
      resp =err.toString();
    }
    return resp;
  }

  Future<String> updateUserProfileData ({
    required String name,
    required String phone,
    required Uint8List file,
  }) async {
    String resp = " Some Error Occurred";
    try{
      if(name.isNotEmpty || phone.isNotEmpty) {
        String imageUrl = await uploadProfileImageToStorage('profileImage', file);
        await _firestore.collection('userProfile').doc(userUID)
            .update({
          'uid': userUID,
          'email': currentUser.email,
          'name': name,
          'phone': phone,
          'profileLink': imageUrl,
          'usertype' : 'resident',
        });

        resp = 'success';
      }
    }
    catch(err){
      resp =err.toString();
    }
    return resp;
  }


}