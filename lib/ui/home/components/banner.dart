import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:project/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../../../components/custom_snackbar.dart';
import '../../../constants/strings.dart';
import '../../../services/provider.dart';
import 'package:project/services/provider.dart';

class DiscountBanner extends StatefulWidget {
  DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  @override

  String location = 'Current location';

  late String lat= '';
  late String long= '';


  /*_callNumber(String number) async{
    await FlutterPhoneDirectCaller.callNumber(number);
  }*/

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: kScaffoldBackgroundColor,
        //borderRadius: BorderRadius.circular(20),
      ),
      child:  Row(
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  //text: "Hey, $userName!",
                  text: "Welcome back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(), // Add Spacer to push AvatarGlow to the end
          AvatarGlow(
            glowColor: kAccentColor4,
            glowRadiusFactor: 0.7,
            duration: Duration(milliseconds: 1700),
            repeat: true,
            animate: true,
            glowShape: BoxShape.circle,
            child: MaterialButton(
              elevation: 3,
              onPressed: () async {
                await getCurrentLocation();
                _sos();
              },
              color: kAccentColor,
              textColor: Colors.white,
              child: Text(
                'SOS',
                style: TextStyle(fontSize: 12),
              ),
              padding: EdgeInsets.all(2),
              shape: CircleBorder(),
            ),
          ),
        ],
      )

    );
  }

  sendNotification(String token) async{
    String url='https://fcm.googleapis.com/fcm/send';
    Uri myUri = Uri.parse(url);
    await http.post(
      myUri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'An Emergency Alert has been triggered! Please check the app for more details.',
            'title': 'Emergency Alert!',
            "sound" : "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': '$token',
        },
      ),
    );

  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat =  '${position.latitude}';
      long = ' ${position.longitude}';
      location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _sos() async {
    print("button of sos pressed");
    FirebaseFirestore.instance.collection('userProfile').where('usertype',isEqualTo: 'guard')
        .get()
        .then((QuerySnapshot querySnapshot) {

          for(int i=0 ; i<querySnapshot.docs.length; i++){
            print(querySnapshot.docs[i].get('name'));
            sendNotification(querySnapshot.docs[i].get('token'));
          }



    });

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('userProfile').doc(FirebaseAuth.instance.currentUser!.uid).get();
    await FirebaseFirestore.instance.collection('generatedSos').add({
      'residentName': userSnapshot.get('name'),
      'residentEmail': userSnapshot.get('email'),
      'currentLocation': 'Latitude: $lat, Longitude: $long',
      'timestamp': FieldValue.serverTimestamp(),
      'resolved': false,
    }).then((value) {
      print('SOS details saved');
      showSosSnackbar(context);
    }).catchError((error) {
      print('Failed to save SOS details: $error');
    });

  }
}