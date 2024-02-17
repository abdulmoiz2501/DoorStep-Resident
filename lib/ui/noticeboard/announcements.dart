import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
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
              height: 20,
            ),
            Text(
              'Announcement',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Image.asset(
              'lib/assets/images/announcements.png',
              height: 150,
              width: 250,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child:FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('announcement').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents = snapshot.data?.docs ?? [];
                        if(snapshot.data!=null){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  ListView(
                                children: documents.map((doc) => Card(
                                  child:Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFF6F35A5)),
                                    ),

                                    child: ListTile(

                                      leading:  SizedBox(
                                        child: Image.asset('lib/assets/images/announcment.png'),
                                      ),


                                      title: Text(doc['title']  ,style: TextStyle(
                                        fontFamily: "Montserrat Medium",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),),

                                      subtitle: SingleChildScrollView(
                                        child: Text( doc['description'],style: TextStyle(
                                          fontFamily: "Montserrat Regular",
                                          fontSize: 15,
                                        ),),
                                      ),

                                    ),
                                  ),)).toList()),
                          );
                        }
                        else {
                          return Text('no data');
                        }
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      else{
                        return Center(child:  CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF8814CC)),
                        ),);
                      }
                    })
            )
          ],
        ),
      ),
    );
  }
}
