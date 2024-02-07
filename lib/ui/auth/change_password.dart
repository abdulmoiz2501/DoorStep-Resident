import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';
import '../../constants/utils.dart';
import '../../services/user_model.dart';

class ChangePassword extends StatefulWidget {
   ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

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

    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
          //leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
          //title: Text(tEditProfile, style: Theme.of(context).textTheme.headline4),
        backgroundColor: kPrimaryColor,
          ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // -- IMAGE with ICON
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
              SizedBox(height: 50),
              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    customTextField("Name", _fullNameController,prefixIcon: Icon(Icons.person)),
                    SizedBox(height: 10),
                    customTextField("Email", _emailController,prefixIcon: Icon(Icons.email)),
                    SizedBox(height: 10),
                    customTextField("Phone", _phoneController,prefixIcon: Icon(Icons.phone)),

                    ///for password including an eye button for viewing pass
                    // TextFormField(
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     label: const Text('Password'),
                    //     prefixIcon: const Icon(Icons.fingerprint),
                    //     suffixIcon: IconButton(
                    //         icon: const Icon(Icons.remove_red_eye),
                    //         onPressed: () {}
                    //     ),
                    //       border: OutlineInputBorder(),
                    //       prefixIconColor: kPrimaryColor,
                    //       floatingLabelStyle: TextStyle(color: kPrimaryColor),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(width: 2,color: kPrimaryColor),
                    //       ),
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: saveProfile,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: Text('Save',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // -- Created Date and Delete Button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text.rich(
                    //       TextSpan(
                    //         text: 'tJoined',
                    //         style: TextStyle(fontSize: 12),
                    //         children: [
                    //           TextSpan(
                    //               text: 'tJoinedAt',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 12))
                    //         ],
                    //       ),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor:
                    //               Colors.redAccent.withOpacity(0.1),
                    //           elevation: 0,
                    //           foregroundColor: Colors.red,
                    //           shape: const StadiumBorder(),
                    //           side: BorderSide.none),
                    //       child: const Text('tDelete'),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(String title, var controller,
      {bool obscure = false,Icon? prefixIcon,}) {
    return TextFormField(
        //readOnly: readOnly,
        obscureText: obscure,
        controller: controller,
      decoration: InputDecoration(
        label: Text('$title',style: TextStyle(
          fontFamily: 'Circular',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kTextColor,
        ),
        ),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIconColor: kPrimaryColor,
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: kPrimaryColor),
        ),
      ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is Empty';
          }
          return null;
        }
    );
  }
}
