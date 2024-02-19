import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ReportIncident2 extends StatefulWidget {
  const ReportIncident2({Key? key}) : super(key: key);

  @override
  _ReportIncident2State createState() => _ReportIncident2State();
}

class _ReportIncident2State extends State<ReportIncident2> {
  int? selectedSeverity;
  int? selectedEvent;

  List<String> severityList = ["High", "Medium", "Low"];
  List<Map<String, dynamic>> eventList = [
    {"label": "Fire", "imagePath": "lib/assets/icons/fire.png"},
    {"label": "Accident", "imagePath": "lib/assets/icons/accident.png"},
    {"label": "Theft", "imagePath": "lib/assets/icons/robber.png"},
    {"label": "Property Damage", "imagePath": "lib/assets/icons/property.png"},
    {"label": "Others", "imagePath": "lib/assets/icons/other.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Incident'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Step 1: Add a title for Severity Level
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                "Select Severity Level",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Step 2: Call the buildSeverityRadioButtons method
            buildSeverityRadioButtons(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // Step 3: Add a title for What Happened
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text(
                "What Happened?",
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ),
            // Step 4: Call the buildEventRadioButtons method
            buildEventRadioButtons(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: () {
          // Step 5: Add logic to check if both severity and event are selected
          if (selectedSeverity != null && selectedEvent != null) {
            // Step 6: Navigate to the report_incident_3 screen and pass selected data
            Navigator.pushNamed(
              context,
              '/report_incident_3',
              arguments: {
                'severity': severityList[selectedSeverity!],
                'event': eventList[selectedEvent!]["label"],
              },
            );
          } else {
            // Step 7: Show a snackbar if either severity or event is not selected
            final snackBar = SnackBar(
              content: Text('Please select both severity level and event!'),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  // Step 8: Extracted method for building Severity Radio Buttons
  Widget buildSeverityRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        severityList.length,
            (index) => InkWell(
          onTap: () {
            setState(() {
              selectedSeverity = index;
            });
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: selectedSeverity == index ? kAccentColor4 : Colors.grey[200],
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Text(
              severityList[index],
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: selectedSeverity == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Step 9: Extracted method for building Event Radio Buttons
  Widget buildEventRadioButtons() {
    return Column(
      children: List.generate(
        eventList.length,
            (index) => InkWell(
          onTap: () {
            setState(() {
              selectedEvent = index;
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 8, left: 0, right: MediaQuery.of(context).size.width/4, bottom: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selectedEvent == index ? kAccentColor4 : Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  eventList[index]["imagePath"],
                  width: 24.0,
                  height: 24.0,
                ),
                SizedBox(width: 16.0),
                Text(
                  eventList[index]["label"],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: selectedEvent == index ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
