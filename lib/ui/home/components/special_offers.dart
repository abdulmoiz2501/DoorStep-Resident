import 'package:flutter/material.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {

  /*List<Map<String, String>> banners = <Map<String, String>>  [
    {
      'name': 'Noticeboard',
      'imagePath': 'lib/assets/images/noticeboard.png',
      'subText': 'Announcements & Notices',
      'routePath': '/noticeboard',
    },
    {
      'name': 'Helpdesk',
      'imagePath': 'lib/assets/images/helpdesk.png',
      'subText': 'Complaints & Suggestions',
      'routePath': '/noticeboard',
    },
    {
      'name': 'Social',
      'imagePath': 'lib/assets/images/social.png',
      'subText': 'Connect and socialize',
      'routePath': '/noticeboard',
    },
    {
      'name': 'Feedback',
      'imagePath': 'lib/assets/images/feedback.png',
      'subText': 'Surveys & Polls',
      'routePath': '/noticeboard',
    },
  ];*/
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Community",
            scrollController: _scrollController,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BannerWidget(
                  imagePath: 'lib/assets/images/noticeboard.png',
                  name: 'Noticeboard',
                  subText: 'Announcements & Notices',
                  routePath: '/noticeboard',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Add more BannerWidgets with different parameters
                BannerWidget(
                  imagePath: 'lib/assets/images/helpdesk.png',
                  name: 'Helpdesk',
                  subText: 'Complaints & Suggestions',
                  routePath: '/chat_page',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Add more BannerWidgets with different parameters
                BannerWidget(
                  imagePath: 'lib/assets/images/incidents.png',
                  name: 'Incidents ',
                  subText: 'Report and View Incidents',
                  routePath: '/reportIncident',
                ),
                BannerWidget(
                  imagePath: 'lib/assets/images/feedback.png',
                  name: 'Feedback',
                  subText: 'Surveys & Polls',
                  routePath: '/feedback',
                ),
              ],
            ),
          ),

        ),
      ],
    );
  }
}



/*class BannerWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String subText;
  final String routePath;


  const BannerWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.subText,
    required this.routePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width - 29,
      child: Container(
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
                Navigator.pushNamed(context, routePath);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.19,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                        ),
                        Text(
                          subText,
                          style: TextStyle(
                            fontSize: 14, // Adjust the font size
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
                                margin: EdgeInsets.only(right: 10),
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
      ),
    );
  }
}*/
class BannerWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String subText;
  final String routePath;

  const BannerWidget({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.subText,
    required this.routePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.8,
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
              Navigator.pushNamed(context, routePath);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.19,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                      ),
                      Text(
                        subText,
                        style: TextStyle(
                          fontSize: 14,
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
                              margin: EdgeInsets.only(right: 10),
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
  }
}



