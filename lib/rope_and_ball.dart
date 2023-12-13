import 'package:flutter/material.dart';

class RopeAndBall extends StatelessWidget {
  const RopeAndBall({
    required this.ballColor,
    required this.ropeColor,
    required this.ballDiameter,
    super.key,
  });

  final double ballDiameter;
  final Color ballColor;
  final Color ropeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //to not match the ground ;)
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 2,
              color: ropeColor,
            ),
          ),
          Container(
            height: ballDiameter,
            width: ballDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color.alphaBlend(ballColor.withOpacity(0.4), Colors.white),
                  Color.alphaBlend(ballColor.withOpacity(0.6), Colors.white),
                  Color.alphaBlend(ballColor.withOpacity(0.8), Colors.black),
                ],
                center: Alignment.topCenter,
                stops: const [0, 0.5, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
