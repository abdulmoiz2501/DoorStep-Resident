import 'package:flutter/material.dart';

import 'package:project/services/date_time_extension.dart';

import '../../../../../constants/colors.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
    this.isSelected = false,
  });

  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: isSelected
            ? kPrimaryColor.withOpacity(0.8)
            : kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            date.monthName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white : null,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              date.day.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: isSelected ? Colors.black : null),
            ),
          ),
        ],
      ),
    );
  }
}
