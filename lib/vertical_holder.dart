import 'package:flutter/material.dart';

class VerticalHolder extends StatelessWidget {
  const VerticalHolder({required this.width, super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey,
            Colors.black,
            Colors.grey,
          ],
          stops: [0.15, 0.5, 0.85],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }
}
