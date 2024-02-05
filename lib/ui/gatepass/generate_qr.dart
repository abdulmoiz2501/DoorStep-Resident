import 'dart:async';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:project/constants/colors.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class GenerateGatepass extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GenerateGatepass> {
  final _screenshotController = ScreenshotController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getUserId() {
    // getting current user id
    final User? user = auth.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      //backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(),
        ),
        body: new SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: new Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Access Control',
                  style: TextStyle(
                    fontFamily: 'Montserrat Medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kTextColor,
                  ),

                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Image.asset(
                  'lib/assets/images/gatepass2.png',
                  width: size.height * 0.35,
                ),

                new Expanded(
                  child: new Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: new Column(
                      children: [

                        SizedBox(height: size.height*0.03,),
                        new Container(
                          child: Screenshot(
                            controller: _screenshotController,
                            child:
                            QrImageView(
                              //place where the QR Image will be shown
                              data: getUserId().toString(),
                              backgroundColor: Colors
                                  .white, // To NOT make it a png (black on black)
                            ),
                          ),
                          height: size.height * 0.4,
                        ),

                        SizedBox(height: size.height * 0.02,),

                        RoundedButton(
                          text: "Share QR",
                          press: () {_takeScreenshot();},
                            key: ValueKey<String>('share_qr_button'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );

  }

  void _takeScreenshot() async
  {
    final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List as List<int>);
    await Share.shareFiles([file.path]);
  }



/*  Future<void> _saveToGallery(File imageFile) async {
    try {
      final result =
      await ImageGallerySaver.saveImage(imageFile.readAsBytesSync());
      debugPrint("Image Stored Successfully !!");
    } on Exception catch (exp) {
      debugPrint("Image Exception ${exp.toString()}");
    }
  }*/


}