import 'package:flutter/material.dart';

//the initial ball or the reacting ball
//if inClockwiseDir==true it's will in clock wise direction so it must be in the start of balls row(I build the row in LTR direction)
//else if inClockwiseDir==false the ball will swing in counter clockwise direction
class SwingChild extends AnimatedWidget {
  final bool inClockwiseDir;
  final Widget child;

  // final bool playSound;

  const SwingChild({
    Key? key,
    required this.inClockwiseDir,
    required this.child,
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
      angle: (inClockwiseDir && animation.value > 0) ||
              (!inClockwiseDir && animation.value < 0)
          ? animation.value
          : 0,
      child: child,
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
