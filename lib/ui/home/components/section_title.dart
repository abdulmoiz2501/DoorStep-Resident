// import 'package:flutter/material.dart';
//
// class SectionTitle extends StatelessWidget {
//   const SectionTitle({
//     Key? key,
//     required this.title,
//     required this.press,
//   }) : super(key: key);
//
//   final String title;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         TextButton(
//           onPressed: press,
//           style: TextButton.styleFrom(foregroundColor: Colors.grey),
//           child: const Text("See more"),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.scrollController,
  }) : super(key: key);

  final String title;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            print('See more button pressed');
            // Scroll to the bottom of the screen
            scrollController.animateTo(

              scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          },
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text("See more"),
        ),
      ],
    );
  }
}
