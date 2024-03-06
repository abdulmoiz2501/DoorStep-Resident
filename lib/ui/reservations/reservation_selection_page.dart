import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';

class ReservationSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Book Amenities'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ReservationOptionTile(
              title: 'Cinema',
              subtitle: 'Enjoy movies in theaters',
              icon: Icons.local_movies,
              iconColor: kPrimaryColor,
              onTap: () {
                // Navigate to cinema reservation page
                Navigator.pushNamed(context, '/movie_booking');
              },
            ),
            SizedBox(height: 20),
            ReservationOptionTile(
              title: 'Wedding Halls',
              subtitle: 'Book marquees for events',
              icon: Icons.star,
              iconColor: kPrimaryColor,
              onTap: () {
                // Navigate to marquee reservation page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor; // New parameter for icon color

  const ReservationOptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.iconColor, // Initialize icon color parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align elements to the start and end
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: iconColor, // Use icon color parameter
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
              color: kPrimaryColor,
              ), // Right arrow icon
            ],
          ),
        ),
      ),
    );
  }
}


