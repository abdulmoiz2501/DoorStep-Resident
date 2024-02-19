import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/constants/colors.dart';
import 'package:project/ui/incident/report_incident.dart';
import 'package:geolocator/geolocator.dart';
import '../../components/progress_dialog.dart';
import '../../constants/utils.dart';

class ReportIncident3 extends StatefulWidget {
  @override
  _ReportIncident3State createState() => _ReportIncident3State();
}

class _ReportIncident3State extends State<ReportIncident3> {
  Uint8List? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  String location = 'Current location';
  late String lat;
  late String long;

  @override
  Widget build(BuildContext context) {
    // Step 1: Retrieve arguments using ModalRoute
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Step 2: Access the severity and event from the arguments
    String severity = arguments['severity'];
    String event = arguments['event'];
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /*Text(
                'Selected Severity: $severity',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Selected Event: $event',
                style: TextStyle(fontSize: 16),
              ),*/

              SizedBox(
                height: size.height * 0.08,
              ),

              Text(
                "Fill the Information",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.08,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 28, 10, 10),
                    child: TextFormField(
                      maxLength: 25,
                      buildCounter: (BuildContext context,
                          {int? currentLength,
                          int? maxLength,
                          bool? isFocused}) {
                        return null; // You can customize the counter if needed
                      },
                      controller: _title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black54,

                        fontSize: 20,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade200,
                  ),
                  height: size.height * 0.25,
                  width: size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 25,
                      controller: _description,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is Empty';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                location,
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  // Container containing "Upload Image" button
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 0,
                        left: 2,
                        right: 8,
                        bottom: 8,
                      ),
                      padding: EdgeInsets.all(16),
                      width: size.width * 0.75, // Adjusted width to take 3/4 of the screen
                      child: ElevatedButton(
                        onPressed: () {
                          _showImageOptions(); // Show modal bottom sheet with options
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kAccentColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: kAccentColor4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _image == null ? "Upload Image" : "Change Image",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(Icons.camera_alt),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      left: 2,
                      right: 8,
                      bottom:9,
                    ),
                    //padding: EdgeInsets.all(8),
                      width: size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        _showLocationOptions();
                        setState(() {
                          location = 'Latitude: $lat, Longitude: $long';
                        });
                        // Handle location icon press
                        // Example: Open a bottom sheet, show location details, etc.
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(
                          color: kAccentColor4, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                        primary: kAccentColor3, // Set the background color
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.location_on,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.01,
              ),
              _image != null
                  ? Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: MemoryImage(_image!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  : Container(),
              SizedBox(
                height: size.height * 0.04,
              ),
              // report button
              SizedBox(
                height: size.height * 0.08,
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await getCurrentLocation();
                      addIncident(
                          _title.text, _description.text, _image!, double.parse(lat), double.parse(long));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kAccentColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(
                        color: kAccentColor4), // Add this line for border
                  ),
                  child: Text(
                    'Report',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  } //second

  _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Upload from Gallery'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  getFromGallery(); // Call the function to upload from gallery
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Picture from Camera'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  // Uncomment the line below if you want to enable taking a picture from the camera
                  getFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _showLocationOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Current Location'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  getCurrentLocation().then((value){
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                  }) ;// Call the function to upload from gallery
                },
              ),
              ListTile(
                leading: Icon(Icons.add_location_alt),
                title: Text('Select Location on Map'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  // Uncomment the line below if you want to enable taking a picture from the camera
                  getFromCamera();
                },
              ),
            ],
          ),
        );
      },
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

  /// Get from gallery
  getFromGallery() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  /// Get from Camera
  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path) as Uint8List?;
      });
    }
  }

  Future<void> addIncident(String title, String description, Uint8List? image,  double latitude, double longitude) async {
    final CollectionReference incident =
        FirebaseFirestore.instance.collection('incidents');

    ProgressDialogWidget.show(context, "Please wait...");

// Show the ProgressDialog

    FirebaseStorage storage = FirebaseStorage.instance;
    String url;
    if (image == null) {
      await incident.doc().set({
        "title": title,
        "description": description,
        "image": null,
        "latitude": latitude,
        "longitude": longitude,
      }).whenComplete(() => ProgressDialogWidget.hide(context));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ReportIncident()));
    } else if (image != null) {
      Reference ref = storage.ref().child("image" + DateTime.now().toString());
      UploadTask uploadTask = ref.putData(image);
      uploadTask.whenComplete(() async {
        url = await ref.getDownloadURL();
        print("url: $url");
        if (url != null) {
          await incident.doc().set({
            "title": title,
            "description": description,
            "image": url,
            "latitude": latitude,
            "longitude": longitude,

          });
        }
      }).catchError((onError) {
        print(onError);
      }).whenComplete(() => ProgressDialogWidget.hide(context));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReportIncident()),
      );
    }
  }
} // last
