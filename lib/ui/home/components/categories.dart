import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:project/constants/colors.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customContainer(
          color: kAccentColor.withOpacity(0.8),
          imagePath: 'lib/assets/images/qr2.png',
          text1: 'Access Control',
          text2: 'Gatepass',
          text3: 'Generate',
          onTap: () {
            // Navigate to your desired screen
            Navigator.pushNamed(context, '/generateQR');
          },
        ),
        SizedBox(width: 4),
        customContainer(
          color: kAccentColor2.withOpacity(0.8),
          imagePath: 'lib/assets/images/Service.png',
          text1: 'Services',
          text2: 'Book',
          text3: 'Book',
          onTap: () {
            // Navigate to your desired screen
            Navigator.pushNamed(context, '/profile');
          },

        ),
        SizedBox(width: 4),
        customContainer(
          color: kAccentColor3.withOpacity(0.8),
          imagePath: 'lib/assets/images/reserve2.png',
          text1: 'Amenities',
          text2: 'Reserve',
          text3: 'Reserve',
          onTap: () {
            // Navigate to your desired screen
            Navigator.pushNamed(context, '/profile');
          },
        )
      ],
      //SOS
      //Feedback
      //???

    );
  }

}

Widget customContainer({
  required Color color,
  required String imagePath,
  required String text1,
  required String text2,
  required String text3,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 150,
      width: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(height: 10),
            Text(
              text1,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            Text(
              text2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8,
                  left: 18,
                  right: 18,
                ),
                child: Text(
                  text3,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

