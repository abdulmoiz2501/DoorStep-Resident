import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, String>> banners = <Map<String, String>>  [
    {
      'name': 'Noticeboard',
      'imagePath': 'lib/assets/images/noticeboard.png',
      'subText': 'Announcements & Notices',
    },
    {
      'name': 'Helpdesk',
      'imagePath': 'lib/assets/images/helpdesk.png',
      'subText': 'Complaints & Suggestions',
    },
    {
      'name': 'Social',
      'imagePath': 'lib/assets/images/social.png',
      'subText': 'Connect and socialize',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: Text(
        //     'Community'.toUpperCase(),
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(top: 15),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: banners.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    child: InkWell(
                      highlightColor: Colors.white.withAlpha(50),
                      onTap: () {
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              banners[index]['imagePath']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  banners[index]['name']!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                Text(
                                  banners[index]['subText']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  height: 25,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
