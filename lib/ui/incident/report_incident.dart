import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:project/constants/colors.dart';

class ReportIncident extends StatelessWidget {
  const ReportIncident({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Incident'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('incidents').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  if (snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: documents
                            .map(
                              (doc) => Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    border: Border.all(color: kPrimaryColor),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            AlertDialog(
                                          title: Column(
                                            children: [
                                              // closing buttons
                                              Align(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                alignment:
                                                    Alignment.centerRight,
                                              ),

                                              // Title text
                                              Align(
                                                child: Container(
                                                  child: Text(
                                                    "Title",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                              ),

                                              SizedBox(
                                                height: 4,
                                              ),
                                              Align(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        //color: kPrimaryColor
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      doc["title"],
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ],
                                          ),
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            child: Column(
                                              children: [
                                                Align(
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      child: Text(
                                                        "Description",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      doc["description"],
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                /*Align(
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      child: Text(
                                                        "Description",
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  alignment:
                                                  Alignment.centerLeft,
                                                ),*/
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: kPrimaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          4),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(
                                                        doc["description"],
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            border: Border.all(
                                                color: kPrimaryColor),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12.0),
                                                topLeft: Radius.circular(12.0)),
                                          ),
                                          child: doc['image'] == null
                                              ? Center(
                                                  child: Text(
                                                    "No Image",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                )
                                              : Image.network(
                                                  doc['image'],
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                ),
                                          height: 150,
                                          width: double.infinity,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                doc['title'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                  // fontFamily: "Montserrat Medium",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                        ),
                                        Divider(
                                          height: 2,
                                          thickness: 1,
                                          indent: 5,
                                          endIndent: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Description",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54,
                                                      // fontFamily: "Montserrat Medium",
                                                    ),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                  height: 20,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: kPrimaryColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Incident",
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    return Text('no data');
                  }
                } else if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  );
                }
              },
            ),
          ),
          SwipeButton(
            borderRadius: BorderRadius.circular(22),
            trackPadding: EdgeInsets.all(6),
            elevationThumb: 2,
            activeTrackColor: kPrimaryColor,
            activeThumbColor: kAccentColor4,
            width: 250,
            child: Text(
              "Swipe to report incident",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onSwipe: () {
              Navigator.pushNamed(context, '/report_incident_2');
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        ],
      ),
    );
  }
}
