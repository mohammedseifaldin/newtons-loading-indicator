import 'package:flutter/material.dart';

class HorizontalHolder extends StatelessWidget {
  const HorizontalHolder({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [
            Colors.grey,
            Colors.black54,
            Colors.black,
          ],
          stops: [0.4, 0.6, 0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
