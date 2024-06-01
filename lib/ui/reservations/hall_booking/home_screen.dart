import 'package:flutter/material.dart';

import '../../../components/items_widget.dart';
import '../../../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Lists for different categories
  List<String> marqueeItems = [
    'Daisy Hall',
    'Lily Hall',
    'Rose Hall',
    'Jasmine Hall',
  ];
  List<String> outdoorItems = [
    'Marina Complex',
    'Defense Orchards',
    'Pine Villa Complex',
  ];
  List<String> rooftopItems = [
    'Bella Vista',
  ];

  // Descriptions corresponding to each item category
  List<String> marqueeDescriptions = [
    '1500-3000 per head',
    '4000-8000 per head',
    '2500-5000 per head',
    '3500-7000 per head',
  ];
  List<String> outdoorDescriptions = [
    '2000-3000 per head',
    '4500-9000 per head',
    '6000-6500 per head',
  ];
  List<String> rooftopDescriptions = [
    '8000 per head',
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Plan your ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Shaadi',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' in 3 minutes!\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'What are you looking for? From intimate ceremonies to grand celebrations, we offer it all.',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: kPrimaryColor,
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: kPrimaryColor,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 5),
                ),
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(
                    text: "Marquee",
                  ),
                  Tab(
                    text: "Outdoor",
                  ),
                  Tab(
                    text: "Rooftop",
                  ),
                ],
              ),
              SizedBox(height: 5),
              Center(
                child: [
                  ItemsWidget(
                    items: marqueeItems,
                    descriptions: marqueeDescriptions,
                  ),
                  ItemsWidget(
                    items: outdoorItems,
                    descriptions: outdoorDescriptions,
                  ),
                  ItemsWidget(
                    items: rooftopItems,
                    descriptions: rooftopDescriptions,
                  ),
                ][_tabController.index],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
