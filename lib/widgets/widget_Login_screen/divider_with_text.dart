import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 36,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Or log in with'),
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 36,
          ),
        ),
      ],
    );
  }
}