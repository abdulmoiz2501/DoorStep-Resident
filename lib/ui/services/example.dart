
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
