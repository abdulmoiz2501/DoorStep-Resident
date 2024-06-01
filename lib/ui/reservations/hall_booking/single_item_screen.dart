import 'package:flutter/material.dart';
import 'menu_selection_screen.dart';

class VenueDetailsWidget extends StatelessWidget {
  final String hallName;

  VenueDetailsWidget(this.hallName);

  @override
  Widget build(BuildContext context) {
    String description = '';
    String pricing = '';
    String staff = '';
    String capacity = '';
    String parkingSpace = '';
    String oneLiner = '';

    // Set details based on hall name
    switch (hallName) {
      case 'Daisy Hall':
        oneLiner = 'Where timeless elegance awaits you.';
        description = 'Daisy Hall offers an exquisite blend of sophistication and charm, providing an ideal setting for your cherished events. With its graceful ambiance and impeccable amenities, Daisy Hall promises to elevate your special occasions to unforgettable heights.';
        pricing = 'Starting from PKR 1500 per head';
        staff = 'Male, Female';
        capacity = 'Up to 200 guests';
        parkingSpace = 'Ample parking available';
        break;
      case 'Lily Hall':
        oneLiner = 'An enchanting ambiance for romance.';
        description = 'Lily Hall provides a serene and elegant atmosphere for your events. With its tasteful decor and spacious layout, Lily Hall is perfect for intimate gatherings and grand celebrations alike.';
        pricing = 'Starting from PKR 2500 per head';
        staff = 'Male, Female';
        capacity = 'Up to 150 guests';
        parkingSpace = 'Limited parking available';
        break;
      case 'Rose Hall':
        oneLiner = 'Discover romantic charm here.';
        description = 'Rose Hall exudes timeless charm and sophistication, offering a picturesque backdrop for your special moments. With its versatile spaces and attentive staff, Rose Hall ensures that your events are memorable.';
        pricing = 'Starting from PKR 3500 per head';
        staff = 'Male, Female';
        capacity = 'Up to 250 guests';
        parkingSpace = 'Valet parking available';
        break;
      case 'Jasmine Hall':
        oneLiner = 'Embrace splendor on your day.';
        description = 'Jasmine Hall is a modern and stylish venue designed to impress. From its contemporary decor to its state-of-the-art amenities, Jasmine Hall is the perfect choice for those seeking elegance and luxury.';
        pricing = 'Starting from PKR 4000 per head';
        staff = 'Male, Female';
        capacity = 'Up to 300 guests';
        parkingSpace = 'Reserved parking available';
        break;
      case 'Defense Orchards':
        oneLiner = 'Experience luxury and grandeur.';
        description = 'Defense Hall offers unparalleled luxury and grandeur for your special events. With its opulent decor and top-notch services, Defense Hall ensures that every moment is unforgettable.';
        pricing = 'Starting from PKR 3000 per head';
        staff = 'Male, Female';
        capacity = 'Up to 350 guests';
        parkingSpace = 'Valet parking available';
        break;
      case 'Marina Complex':
        oneLiner = 'A blend of elegance and modernity.';
        description = 'Marina Complex combines elegance with modern amenities, offering a versatile space for various events. With its scenic views and luxurious ambiance, Marina Complex is the perfect choice for any occasion.';
        pricing = 'Starting from PKR 2800 per head';
        staff = 'Male, Female';
        capacity = 'Up to 400 guests';
        parkingSpace = 'Ample parking available';
        break;
      case 'Pine Villa Complex':
        oneLiner = 'Where nature meets sophistication.';
        description = 'Pine Villa Complex provides a tranquil setting amidst nature, combining sophistication with natural beauty. With its spacious halls and serene surroundings, Pine Villa Complex offers the perfect retreat for your events.';
        pricing = 'Starting from PKR 3200 per head';
        staff = 'Male, Female';
        capacity = 'Up to 250 guests';
        parkingSpace = 'Reserved parking available';
        break;
      case 'Bella Vista':
        oneLiner = 'Elevate your events with panoramic views.';
        description = 'Bella Vista offers stunning panoramic views and a luxurious ambiance, making it the ideal choice for elegant events. With its spacious halls and impeccable services, Bella Vista promises to elevate your events to unforgettable heights.';
        pricing = 'Starting from PKR 3800 per head';
        staff = 'Male, Female';
        capacity = 'Up to 200 guests';
        parkingSpace = 'Valet parking available';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow("VENUE TYPE", "Hall", Icons.home, oneLiner),
        _buildDetailRow("CATERING", "Internal", Icons.food_bank, ""),
        _buildDetailRow("WHEELCHAIR ACCESSIBLE", "Yes", Icons.accessible, ""),
        _buildDetailRow("STAFF", staff, Icons.people, ""),
        _buildDetailRow("CANCELLATION POLICY", "Partially Refundable", Icons.money, ""),
        _buildDetailRow("CAPACITY", capacity, Icons.group, ""),
        _buildDetailRow("PARKING SPACE", parkingSpace, Icons.local_parking, ""),
        _buildDetailRow("DESCRIPTION", description, Icons.description, ""),
        _buildDetailRow("PRICING", pricing, Icons.attach_money, ""),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.purple),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 3),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class SingleItemScreen extends StatelessWidget {
  final String hallName;

  SingleItemScreen(this.hallName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    'lib/assets/images/$hallName.jpg',
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    hallName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                VenueDetailsWidget(hallName),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.purple, // Set the background color to purple
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the next screen and pass hallName
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuSelectionScreen(hallName: hallName),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Select Menu',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set the text color to white
                        ),
                      ),
                    ),
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
