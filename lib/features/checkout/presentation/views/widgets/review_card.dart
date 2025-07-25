import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final Widget body;
  const ReviewCard({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: body,
    );
  }
}
