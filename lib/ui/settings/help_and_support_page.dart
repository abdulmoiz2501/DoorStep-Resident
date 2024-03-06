import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:project/constants/colors.dart';

class HelpCentre extends StatelessWidget {
  const HelpCentre({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          'Help Centre',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, how can we help you?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Here's a list of our frequently asked questions. Please go through them and see if you can find what you are looking for.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Accordion(
                children: [
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('What is DoorStep Resident app?'),
                    content: Text('DoorStep Resident app is a mobile application designed specifically for residents of our gated community. It provides convenient access to various community services and features right at your fingertips.' ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('How do I generate a QR code using the DoorStep Resident app?'),
                    content: Text('To generate a QR code, simply navigate to the QR code generation section within the app. Follow the prompts to input the necessary information, such as your name and unit number, and the app will generate a QR code unique to you.' ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('What services can I access through the DoorStep Resident app?'),
                    content: Text('You can access a variety of services including maintenance requests, package delivery notifications, event registrations, and more.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('How do I book amenities using the DoorStep Resident app?'),
                    content: Text('Booking amenities is easy with our app. Simply navigate to the amenities section, select the amenity you wish to book, choose the date and time, and confirm your booking.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('How can I report incidents through the DoorStep Resident app?'),
                    content: Text('Reporting incidents is important for maintaining community safety. You can report incidents directly through the app by providing details such as the nature of the incident, location, and any relevant information.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('Is there a way to provide feedback on community services?'),
                    content: Text('Absolutely! We encourage residents to provide feedback on community services. You can do so within the app by accessing the feedback section and submitting your comments or suggestions.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('What is the SOS feature in the DoorStep Resident app?'),
                    content: Text('The SOS feature is a critical tool for emergencies. In case of emergencies, you can activate the SOS feature within the app which will immediately alert community security and emergency services.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('Can I communicate with other residents through the DoorStep Resident app?'),
                    content: Text('Yes, the app includes an in-app chat feature that allows residents to communicate with each other securely and conveniently.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('Is my personal information secure within the DoorStep Resident app?'),
                    content: Text('We take privacy and security seriously. Your personal information is encrypted and stored securely within our system to ensure maximum protection.'),
                  ),
                  AccordionSection(
                    headerBackgroundColor: kAccentColor3,
                    headerBorderWidth: 5,
                    header: Text('How do I get help or technical support with the DoorStep Resident app?'),
                    content: Text('If you encounter any issues or need assistance with the app, you can reach out to our support team through the app\'s help section or contact our customer support directly for assistance.'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                  'Getting started',
                   style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Welcome to DoorStep - your gateway to seamless living within our gated community! Getting started with DoorStep is quick and easy. Simply download the DoorStep Resident app from the App Store or Google Play Store, and sign up using your residency details. Once logged in, you'll gain instant access to a plethora of community services and features designed to enhance your living experience. From generating QR codes for seamless access to facilities, booking amenities for your leisure, reporting incidents for prompt resolution, to engaging in community feedback and emergency SOS services - DoorStep has you covered. Explore our app and discover how DoorStep can simplify and elevate your residency experience within our vibrant community.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'About us',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              ),
              SizedBox(height: 5),
              Text("At DoorStep, we are dedicated to fostering a vibrant and secure living environment within our gated community. Our mission is to provide residents with innovative solutions that streamline everyday tasks and enhance community living. With a focus on convenience, safety, and community engagement, DoorStep offers a comprehensive suite of features designed to meet the diverse needs of our residents. From facilitating seamless access to amenities and services, to enabling swift incident reporting and emergency assistance, our platform is built to empower residents and promote a sense of belonging. With DoorStep, we strive to create a connected and harmonious community where residents thrive and flourish together.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Community guidelines',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Text("At DoorStep, we believe in fostering a safe, respectful, and inclusive community environment for all residents. Our community guidelines serve as the foundation for promoting positive interactions and mutual respect among residents. We encourage all members to treat each other with kindness, empathy, and understanding, while upholding the values of honesty, integrity, and accountability. Respect for privacy, adherence to community rules and regulations, and responsible use of community amenities are essential for maintaining harmony and well-being within our community. By adhering to these guidelines, we can collectively create a welcoming and supportive environment where everyone feels valued and empowered to contribute positively to our shared community experience.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Contact us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Have questions, feedback, or need assistance? We're here to help! Feel free to reach out to our dedicated support team via email at support@doorstepapp.com. Our team is available to assist you with any inquiries, technical support, or feedback you may have regarding the DoorStep Resident app. We value your input and strive to provide prompt and personalized assistance to ensure your experience with DoorStep is seamless and enjoyable.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
