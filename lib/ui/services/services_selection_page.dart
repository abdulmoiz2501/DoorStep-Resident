import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/service_provider.dart';
import '../../components/custom_card.dart';
import '../../constants/colors.dart';

class ServicesSelectionPage extends StatelessWidget {
  const ServicesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProviderProvider = Provider.of<ServiceProviderProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new Column(
          children: [
            SizedBox(
              height: 5,
            ),

            Text(
              'Services',
              style: TextStyle(
                fontFamily: 'Montserrat Medium',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kTextColor,
              ),
            ),

/*            Image.asset(
              'lib/assets/images/services.png',
              height: 120,
              width: 168,
            ),*/
            SizedBox(
              height: 5,
            ),
            // report an incident
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(color: Colors.black),
                  color: kAccentColor2,
                ),
                height: 40,
                width: 280,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Select the type of service:",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat Regular",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Icon(
                      Icons.home_repair_service,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 2,
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/electrician2.png',
              title: 'Electricians',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[0]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/plumber.png',
              title: 'Plumbers',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[1]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/painter.png',
              title: 'Painters',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[2]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/mechanic.png',
              title: 'Car Mechanics',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[3]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/maid.png',
              title: 'House helps',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[4]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
            CustomCard(
              assetImage: 'lib/assets/icons/gardener.png',
              title: 'Gardeners',
              onTap: () {
                serviceProviderProvider.selectService(serviceProviderProvider.services[5]);
                Navigator.pushNamed(context, '/serviceDetails');
                // Your onTap logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}



