import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Providers/service_provider.dart';
import '../../constants/colors.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  CollectionReference ref = FirebaseFirestore.instance.collection('service');
  @override
  Widget build(BuildContext context) {
    final serviceProviderProvider =
        Provider.of<ServiceProviderProvider>(context);
    final selectedService = serviceProviderProvider.selectedService;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ListTile(
                leading: Image.asset(
                    serviceProviderProvider.selectedService!.assetImage),
                title: Text(serviceProviderProvider
                    .selectedService!.title), // Provide a default text
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              child: Text(
                'Select any listed service providers to view details:',
                style: TextStyle(
                  fontFamily: 'Montserrat Medium',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance.collection('service').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (snapshot.data != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                children: documents
                                    .map(
                                      (doc) => Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: kPrimaryColor),
                                          ),
                                          child: ListTile(
                                            leading: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              child: CircleAvatar(
                                                  child: Image.network(
                                                      doc['img'])),
                                            ),
                                            trailing: Wrap(
                                              spacing:
                                                  12, // space between two icons
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: Icon(
                                                      Icons.call,
                                                      color: Colors.green,
                                                    ),
                                                    onTap: () {
                                                      _service('tel:' +
                                                          doc['number']);
                                                    },
                                                ),
                                              ],
                                            ),
                                            title: Text(
                                              doc['Provider Name'],
                                              style: TextStyle(
                                                fontFamily: "Montserrat Medium",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doc['number'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Montserrat Regular",
                                                  ),
                                                ),
                                                Text(
                                                  doc['Service Name'],
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Montserrat Regular",
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      initialRating: double.parse(doc['rating'] ?? '0'),// You can set the initial rating here
                                                      minRating: 1,
                                                      ignoreGestures: false,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0),
                                                      itemBuilder: (context, _) => Transform.scale(
                                                        scale: 0.6,
                                                        child: Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        // Handle rating updates
                                                        updateRating(doc.id, rating);
                                                        print('New rating: $rating');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                    'Rs. ${doc['rate']} /hr.',
                                                  style: TextStyle(
                                                    fontFamily:
                                                    "Montserrat Regular",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                          );
                        } else {
                          return Text('no data');
                        }
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                               kPrimaryColor),
                          ),
                        );
                      }
                    },),),
          ],
        ),
      ),
    );
  }

  _service(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }
}
Future<void> updateRating(String documentId, double newRating) async {
  try {
    await FirebaseFirestore.instance.collection('service').doc(documentId).update({
      'rating': newRating.toString(),
    });
    print('Rating updated successfully!');
  } catch (error) {
    print('Error updating rating: $error');
  }
}
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../Providers/service_provider.dart';
import '../../components/custom_card.dart';
import '../../constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsPage extends StatefulWidget {
  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  CollectionReference ref = FirebaseFirestore.instance.collection('service');
  @override
  Widget build(BuildContext context) {
    final serviceProviderProvider =
        Provider.of<ServiceProviderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    leading: Image.asset(
                        serviceProviderProvider.selectedService!.assetImage),
                    title: Text(serviceProviderProvider.selectedService!.title),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
              child: Text(
                'Select any listed service providers to view details:',
                style: TextStyle(
                  fontFamily: 'Montserrat Medium',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: kTextColor,
                ),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('service').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
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
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      border: Border.all(color: kAccentColor),
                                    ),
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(
                                            'assets/icons/services.png'),
                                      ),
                                      trailing: Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(
                                              Icons.message,
                                              color: Colors.amber,
                                            ),
                                            onTap: () {
                                              _service('sms:' + doc['number']);
                                            },
                                          ),
                                          GestureDetector(
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.green,
                                              ),
                                              onTap: () {
                                                _service(
                                                    'tel:' + doc['number']);
                                              }),
                                        ],
                                      ),
                                      title: Text(
                                        doc['Service Name'],
                                        style: TextStyle(
                                          fontFamily: "Montserrat Medium",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        doc['number'],
                                        style: TextStyle(
                                          fontFamily: "Montserrat Regular",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()),
                    );
                  } else {
                    return Text('no data');
                  }
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFF6F35A5)),
                    ),
                  );
                }
              },
            ),

 Column(
              children: [
                CustomCard(
                  assetImage: 'lib/assets/icons/painter.png',
                  title: 'Painters',
                  onTap: () {
                    Navigator.pushNamed(context, '/serviceDetails');
                    // Your onTap logic here
                  },
                ),
                CustomCard(
                  assetImage: 'lib/assets/icons/painter.png',
                  title: 'Painters',
                  onTap: () {
                    Navigator.pushNamed(context, '/serviceDetails');
                    // Your onTap logic here
                  },
                ),
              ],
            ),


            // ... other content of the details page
          ],
        ),
      ),
    );
  }
}

_service(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print(e);
  }
}
*/
