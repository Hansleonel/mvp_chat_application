import 'package:flutter/material.dart';

class MyMessageBubble extends StatelessWidget {
  const MyMessageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // using the color theme with Material 3
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'text for message',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 4)
      ],
    );
  }
}
