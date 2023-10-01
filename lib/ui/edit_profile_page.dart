import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/constants/colors.dart';
import 'package:project/constants/utils.dart';
import 'package:project/services/user_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();

  Uint8List? _image;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  void saveProfile() async {
    if (_image != null) {
      print('inside save profile');
      String resp = await StoreData().updateUserProfileData(
        name: _fullNameController.text,
        phone: _phoneController.text,
        file: _image!,
      );
    } else {
      // Handle the case when _image is null
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Edit Profile'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.08,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.1,
                          backgroundImage:
                              AssetImage('lib/assets/images/avatar.png'),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(Icons.camera_alt),
                    ),
                    bottom: 0,
                    right: 0,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          customTextField("Full Name", _fullNameController, size),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          customTextField("Phone Number", _phoneController, size),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),


          ElevatedButton(
            onPressed: saveProfile,
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget customTextField(String title, var controller, Size size,
      {bool readOnly = false}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '         $title',
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.065),
            child: TextFormField(
                readOnly: readOnly,
                obscureText: false,
                controller: controller,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kWhite,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  fillColor: kTextBoxColor,
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is Empty';
                  }
                  return null;
                }
                ),
          ),
        ),
      ],
    );
  }
}
