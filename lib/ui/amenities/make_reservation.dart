import 'package:project/ui/amenities/amenities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:project/constants/colors.dart';

class MakeReservation extends StatefulWidget {
  @override
  _MakeReservationState createState() => _MakeReservationState();
}

class _MakeReservationState extends State<MakeReservation> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getUserId() {
    // getting current user id
    final User? user = auth.currentUser;
    return user?.uid;
  }

  var _chosenValueVenue ;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _occasion = TextEditingController();
  final TextEditingController _person = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
        ),
      ),
      body :Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                Text("Make Reservation",style: TextStyle(
                  fontFamily: 'Montserrat Medium',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kTextColor,
                ),),

                SizedBox(
                  height: size.height*0.04,
                ),

                // ENTER OCASSION
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey.shade300),
                      color: Colors.grey.shade200,
                    ),
                    height: size.height*0.08,
                    width: size.width*0.9,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0,22,10,10),
                      /*child: TextFormField(
                        maxLength: 25,
                        buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                        controller: _occasion,
                        validator: (value) {
                          if (value.isEmpty) {
                            return '*';
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
                        decoration: InputDecoration (
                          hintText: "Enter Occasion",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),*/
                      child: TextFormField(
                        maxLength: 25,
                        buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }) => Container(),
                        controller: _occasion,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*';
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
                        decoration: InputDecoration (
                          hintText: "Enter Occasion",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: -35.0, horizontal:0.0),
                        ),
                        //textAlign: TextAlign.start,
                      ),


                    ),

                  ),
                ),

                SizedBox(
                  height: size.height*0.04,
                ),

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey.shade300),
                      color: Colors.grey.shade200,
                    ),
                    height: size.height*0.08,
                    width: size.width*0.9,
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 26,
                      elevation: 16,
                      underline: SizedBox(),
                      value: _chosenValueVenue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black54,
                        fontFamily: 'Montserrat Regular',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),

                      items: <String>[
                        'Central park',
                        'Coffee Shop',
                        'Cafe 24/7',
                        'Hotel Pearl',
                        'Pizza Hut',
                        'Tokyo Cafe',
                        'Club 90',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Choose Venue",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontFamily: 'Montserrat Regular',
                            fontWeight: FontWeight.w900),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _chosenValueVenue = value ?? ''; // If value is null, default to an empty string
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height*0.04,
                ),

                //calender
                Row(
                  children: [
                    SizedBox(
                      width: size.width*0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color:Colors.grey.shade300),
                        color: Colors.grey.shade200,
                      ),
                      height: size.height*0.08,
                      width: size.width*0.55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,12,12,12),
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontFamily: 'Montserrat Regular'),
                        ),

                      ),

                    ),
                    SizedBox(
                      width: size.width*0.04,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context), // Your onPressed callback
                      style: ElevatedButton.styleFrom(
                        primary: kAccentColor, // Set the button color
                        onPrimary: Colors.white, // Set the text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Text(
                        'Select date',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                ),

                SizedBox(
                  height: size.height*0.04,
                ),

                // reserve members
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color:Colors.grey.shade300),
                      color: Colors.grey.shade200,
                    ),
                    height: size.height*0.08,
                    width: size.width*0.9,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0,22,10,10),
                      /*child: TextFormField(
                        maxLength: 25,
                        buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                        controller: _person,
                        validator: (value) {
                          if (value.isEmpty) {
                            return '*';
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
                        decoration: InputDecoration (
                          hintText: "Enter Persons",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),*/
                      child: TextFormField(
                        maxLength: 25,
                        buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                          // Return a widget here, such as a Text widget displaying the character count
                          return Text('$currentLength/$maxLength');
                        },
                        controller: _person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*';
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
                          hintText: "Enter Person",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: -35.0, horizontal:0.0),
                        ),
                      ),


                    ),

                  ),
                ),

                SizedBox(
                  height: size.height*0.2,
                ),

                // reserve button
                /*SizedBox(
                  height: size.height*0.08,
                  width: size.width*0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        makeReservation(_occasion.text, _chosenValueVenue.toString() ,selectedDate.toLocal().toString().split(' ')[0], _person.text);
                      }
                    },
                    color: Color(0xff6F35A5),
                    child: Text(
                      'Reserve',
                      style: TextStyle(
                        fontFamily: 'Montserrat Medium',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.black)),


                  ),

                ),*/
                SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      print('reserve pressed');
                      if (_formKey.currentState!.validate()) {
                        makeReservation(
                          _occasion.text,
                          _chosenValueVenue.toString(),
                          selectedDate.toLocal().toString().split(' ')[0],
                          _person.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kAccentColor, // Set the background color here
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text(
                      'Reserve',
                      style: TextStyle(
                        fontFamily: 'Montserrat Medium',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),





              ],
            ),
          ),
        ),
      ),
    );
  }
/*  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
builder: (context, child) {
        return Theme(
          data: ThemeData., // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }*/
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


 /* Future <void> makeReservation(String occasion , String venue , String date , String person  )async {

    final CollectionReference incident =  FirebaseFirestore.instance.collection('Reservation');

    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
      ),
      progress: 0,
      maxProgress: 100,
    );
    pr.show();

    FirebaseStorage storage = FirebaseStorage.instance;
    try{
      await incident.doc().set({
        "occasion": occasion,
        "venue": venue,
        "date": date,
        "person": person,
        "uid": getUserId().toString(),

      }).whenComplete(() => {
        pr.hide(),
        Navigator.pushReplacement(context, MaterialPageRoute(builder : (context)=> Reservation()),),
      });
    }
    catch (e)
    {
      print(e);
    }



  }*/
  Future<void> makeReservation(String occasion, String venue, String date, String person) async {
    final CollectionReference incident = FirebaseFirestore.instance.collection('Reservation');

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      max: 100, // Use 'max' instead of 'maxProgress'
      msg: 'Please Wait...', // Use 'msg' instead of 'message'
      progressType: ProgressType.valuable, // Use 'ProgressType.valuable'
      backgroundColor: kAccentColor4,
    );

    try {
      await incident.add({
        "occasion": occasion,
        "venue": venue,
        "date": date,
        "person": person,
        "uid": getUserId().toString(),
      }).then((DocumentReference document) async {
        pd.update(
          msg: 'Booked!',
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Reservation()));
      });
    } catch (e) {
      pd.close(delay: Duration(milliseconds: 50).inMilliseconds);
      print(e);
    }
  }







}

