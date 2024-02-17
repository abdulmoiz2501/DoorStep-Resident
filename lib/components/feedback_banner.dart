import 'package:flutter/material.dart';
import 'package:project/components/profile_page_tab.dart';
import '../constants/colors.dart';

class FeedbackBanner extends StatelessWidget {
  FeedbackBanner({super.key});
  Size size = MediaQueryData().size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:[
          Text(
            'Feedback',
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: kTextColor,
            ),
          ),
          ProfilePageTab(
            onTap: (){
              Navigator.pushNamed(context, '/survey');
            },
            text: "Survey",
            leadingIcon: Icons.insert_chart_outlined,
            endingIcon: Icons.arrow_forward_ios,
          ),
          ProfilePageTab(
            onTap: (){
              Navigator.pushNamed(context, '/polls');
            },
            text: "Polls",
            leadingIcon: Icons.how_to_vote_outlined,
            endingIcon: Icons.arrow_forward_ios,
          ),
        ]
      ),

    );
  }
}
