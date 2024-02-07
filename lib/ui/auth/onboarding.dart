import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';



class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  late PageController _pageController;
  int _pageIndex = 0;




  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:kPrimaryLightColor,
      body: Padding(
        padding: EdgeInsets.all(height*0.02),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: demo_data.length,
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) =>  OnboardingContent(
                image:demo_data[index].image,
                title: demo_data[index].title,
                description: demo_data[index].description,

              ),
              ),
            ),
            Row(
              children: [
                ...List.generate(demo_data.length, (index) => Padding(
                  padding: const EdgeInsets.only(right:4),
                  child: DotIndicator(isActive: index==_pageIndex, height: height, width: width),
                )),
                Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: kPrimaryColor,
                    ),
                    child: Image.asset(
                      'lib/assets/images/right-arrow.png',
                    color: kPrimaryLightColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.height,
    required this.width,
    this.isActive = false,
  });

  final bool isActive;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? height*0.025: height *0.01,
      width: width*0.01,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : kPrimaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class Onboard{
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description
  });
}

final List<Onboard> demo_data =[
  Onboard(
    image: 'lib/assets/images/onboard1.png',
    title: 'Welcome to the app',
    description: 'welcoming text, info about the app, name and what will it add to your life',
  ),
  Onboard(
    image: 'lib/assets/images/onboard2.png',
    title: 'title 2',
    description: 'idk what to write here',
  ),
  Onboard(
    image: 'lib/assets/images/onboard5.png',
    title: 'title 3',
    description: 'idfk what to write here',
  ),
];


class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key, required this.image, required this.title, required this.description,
  });

  final String image,title,description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
            title,
        textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
         description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
