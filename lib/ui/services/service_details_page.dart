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
  late CollectionReference ref;

  @override
  void initState() {
    super.initState();
    final serviceProviderProvider =
    Provider.of<ServiceProviderProvider>(context, listen: false);

    // Set the collection reference based on the selected service
    ref = FirebaseFirestore.instance.collection(serviceProviderProvider.selectedService!.title.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    final serviceProviderProvider =
    Provider.of<ServiceProviderProvider>(context);
    final selectedService = serviceProviderProvider.selectedService;
    final collectionName = selectedService!.title.toLowerCase(); // Get the collection name

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
                'Call any service proivder to book:',
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
                future: ref.get(),
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
                                    borderRadius: BorderRadius.circular(8),
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
                                                doc['number'].toString());
                                          },
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      doc['Provider Name'],
                                      style: TextStyle(
                                        fontFamily:
                                        "Montserrat Medium",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['number'].toString(),
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating: double.parse(doc['averageRating'] ?? '0'), // You can set the initial rating here
                                              minRating: 1,
                                              ignoreGestures: false,
                                              direction: Axis.horizontal,
                                              allowHalfRating: false,
                                              itemCount: 5,
                                              itemPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              itemBuilder: (context, _) =>
                                                  Transform.scale(
                                                    scale: 0.6,
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                              onRatingUpdate: (rating) {
                                                print('Document ID: ${doc.id}');

                                                // Handle rating updates
                                                double currentRating = double.parse(doc['rating'] ?? '0');
                                                int numberOfRatings = int.parse(doc['numberOfRatings'] ?? '0');
                                                double newAverageRating = ((currentRating * numberOfRatings) + rating) / (numberOfRatings + 1);

                                                updateRating(collectionName, doc.id, rating, newAverageRating, numberOfRatings + 1);
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
                },
              ),
            ),
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
Future<void> updateRating(
    String collectionName, // Pass the collection name as a parameter
    String documentId,
    double newR,
    double averageRating,
    int numberOfRatings
    ) async {
  try {
    await FirebaseFirestore.instance.collection(collectionName).doc(documentId).update({
      'rating': newR.toString(),
      'numberOfRatings': numberOfRatings.toString(),
      'averageRating': averageRating.toString(),
    });
    print('Rating updated successfully!');
  } catch (error) {
    print('Error updating rating: $error');
  }
}

