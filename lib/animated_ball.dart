import 'package:flutter/material.dart';

import 'ball.dart';

class AnimatedBall extends AnimatedWidget {
  final bool clockwise;
  final Color mainColor;
  final Color threadColor;
  final double ballSize;
  // final bool playSound;

  const AnimatedBall({
    Key? key,
    required this.clockwise,
    required this.mainColor,
    required this.threadColor,
    required this.ballSize,
    // required this.playSound,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);
  // bool soundPlayed = false;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    // hitSoundManage(animation);
    return Transform.rotate(
      alignment: Alignment.topCenter,
      angle: (clockwise && animation.value > 0) ||
              (!clockwise && animation.value < 0)
          ? animation.value
          : 0,
      child: ConstBall(
        ballColor: mainColor,
        threadColor: threadColor,
        ballSize: ballSize,
      ),
    );
  }

  // void hitSoundManage(Animation<double> animation) async {
  //   if (playSound) {
  //     if (animation.value > 0 && !(soundPlayed)) {
  //       //for run only one
  //       soundPlayed = true;
  //       await SystemSound.play(SystemSoundType.click);
  //     } else if (animation.value > 0.1 && soundPlayed) {
  //       soundPlayed = false; //to run it again in the next hit
  //     }
  //   }
  // }
}
