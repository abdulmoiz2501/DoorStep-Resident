import 'package:project/ui/reservations/make_reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/constants/colors.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? getUserId() {
    // getting current user id
    final User? user = auth.currentUser;
    return user?.uid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
        ),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new Column(
          children: [
            SizedBox(
              height: 25,
            ),

            Text(
              'Reservation',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kTextColor,
              ),
            ),

            Image.asset(
              'lib/assets/images/amenities.png',
              height: 150,
              width: 250,
            ),
            SizedBox(
              height: 5,
            ),
            // report an incident
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.black),
                  color: kAccentColor,
                ),
                height: 40,
                width: 280,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Make a Reservation ",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MakeReservation()),
                );
              },
            ),

            SizedBox(
              height: 10,
            ),

            Expanded(
                child:FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('Reservation').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot<Object?>>? documents = snapshot.data?.docs.cast<DocumentSnapshot<Object?>>();
                        if(snapshot.data!=null ){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                children: documents!.map((doc) => Card(
                                  child: doc["uid"]== getUserId().toString() ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFF6F35A5)),
                                    ),

                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: kAccentColor),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          reservationData(doc['occasion'], doc['venue'], doc['date'], doc['person'])
                                        ],
                                      ),
                                    ),
                                  ) : SizedBox(),
                                )).toList()),
                          );
                        }
                        else {
                          return Center(child: Text('No data'));
                        }
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      else{
                        return Center(child:  CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF1811A7)),
                        ),);
                      }
                    })
            ),

          ],
        ),
      ),
    );
  }
  Widget reservationData(String occasion, String venue , String date , String person)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        children: [
          SizedBox(
            height: 5,
          ),

          new Row(
            children: [

              SizedBox(
                width: 5,
              ),
              Icon(Icons.ac_unit_outlined,color: Colors.teal,),

              SizedBox(
                width: 15,
              ),


              new Text(
                'Occasion : ',
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 15,
              ),
              new Text(
                occasion,
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Divider(
            height: 10,
            indent: 35,
            endIndent: 35,
            color: Colors.grey.shade900,
            thickness: 1.5,
          ),

          SizedBox(
            height: 5,
          ),

          new Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(Icons.location_on,color: Colors.red,),

              SizedBox(
                width: 15,
              ),

              new Text(
                "Venue : ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 15,
              ),
              new Text(
                venue,
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Divider(
            height: 10,
            indent: 35,
            endIndent: 35,
            color: Colors.grey.shade900,
            thickness: 1.5,
          ),


          SizedBox(
            height: 5,
          ),

          new Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(Icons.date_range,color: Colors.blue,),

              SizedBox(
                width: 15,
              ),

              new Text(
                "Date : ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 15,
              ),
              new Text(
                date,
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Divider(
            height: 10,
            indent: 35,
            endIndent: 35,
            color: Colors.grey.shade900,
            thickness: 1.5,
          ),


          SizedBox(
            height: 5,
          ),

          new Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(Icons.people_alt_sharp,color: Colors.amber,),

              SizedBox(
                width: 15,
              ),

              new Text(
                "Person : ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 15,
              ),
              new Text(
                person,
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat Medium",fontWeight: FontWeight.w600),
              ),
            ],
          ),

          Divider(
            height: 15,
            indent: 35,
            endIndent: 35,
            color: Colors.grey.shade900,
            thickness: 1.5,
          ),



        ],
      ),
    );
  }

}