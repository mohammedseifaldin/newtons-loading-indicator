import 'package:flutter/material.dart';

class ConstBall extends StatelessWidget {
  const ConstBall({
    required this.ballColor,
    required this.threadColor,
    required this.ballSize,
    super.key,
  });

  final double ballSize;
  final Color ballColor;
  final Color threadColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 2,
              color: threadColor,
            ),
          ),
          Container(
            height: ballSize,
            width: ballSize,
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
