import 'package:flutter/material.dart';
import 'package:project/constants/colors.dart';
//import 'package:shop_app/screens/products/products_screen.dart';

import '../../../components/card_model.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Community",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(

              children: [
                CourseCard(
                  context: context,
                  imagePath: 'lib/assets/images/qr2.png',
                  text1: 'Noticeboard',
                  color: kAccentColor.withOpacity(0.8),
                ),
                // SpecialOfferCard(
                //   image: "lib/assets/images/google.png",
                //   category: "Smartphone",
                //   numOfBrands: 18,
                //   press: () {
                //    // Navigator.pushNamed(context, ProductsScreen.routeName);
                //   },
                // ),
                const SizedBox(width: 20),
                // SpecialOfferCard(
                //   image: "lib/assets/images/google.png",
                //   category: "Fashion",
                //   numOfBrands: 24,
                //   press: () {
                //     //Navigator.pushNamed(context, ProductsScreen.routeName);
                //   },
                // ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


Widget CourseCard({
  required BuildContext context,
  required String imagePath,
  required String text1,
  required Color color,
}) {
   double cardWidth = MediaQuery.of(context).size.width - 10;
  return Container(
    color: Colors.black.withOpacity(0.1),
    height: MediaQuery.of(context).size.height * 0.17,
    width:  cardWidth,
    //margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.17,
            width:  cardWidth,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: 40.0,
          child: Text(
            text1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        )
      ],
    ),
  );
}


// class SpecialOfferCard extends StatelessWidget {
//   const SpecialOfferCard({
//     Key? key,
//     required this.category,
//     required this.image,
//     required this.numOfBrands,
//     required this.press,
//   }) : super(key: key);
//
//   final String category, image;
//   final int numOfBrands;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: GestureDetector(
//         onTap: press,
//         child: SizedBox(
//           width: 242,
//           height: 100,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   image,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black54,
//                         Colors.black38,
//                         Colors.black26,
//                         Colors.transparent,
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 10,
//                   ),
//                   child: Text.rich(
//                     TextSpan(
//                       style: const TextStyle(color: Colors.white),
//                       children: [
//                         TextSpan(
//                           text: "$category\n",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(text: "$numOfBrands Brands")
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }