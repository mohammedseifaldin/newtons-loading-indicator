library newtons_cradle_loading_indicator;

import 'dart:math';

import 'package:flutter/material.dart';

import 'animated_ball.dart';
import 'ball.dart';
import 'horizontal_holder.dart';
import 'vertical_holder.dart';

class NewtonLoadingIndicator extends StatefulWidget {
  final Size? widgetSize;
  final String? message;
  final Color? mainColor;
  final double? ballSize;
  final double? holderThick;
  final Color threadColor;
  final double rotationDegree;
  final Duration animationDuration;
  // final bool allowCrossBoundaries;
  // final bool wantHitSound;

  const NewtonLoadingIndicator({
    this.message,
    this.holderThick,
    this.widgetSize,
    this.mainColor,
    this.ballSize,
    this.rotationDegree = 45,
    this.threadColor = Colors.grey,
    // this.allowCrossBoundaries = false,
    // this.wantHitSound = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    super.key,
  }) : assert(rotationDegree > 0 && rotationDegree < 90);

  @override
  State<NewtonLoadingIndicator> createState() => _NewtonLoadingIndicatorState();
}

class _NewtonLoadingIndicatorState extends State<NewtonLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  late double rotateAngle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
    _initRotateAnimation(widget.rotationDegree);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////////////////////////////////////////////init
    final widgetHeight =
        widget.widgetSize?.height ?? MediaQuery.sizeOf(context).height / 3;
    final widgetWidth = _getWidth(context);
    final ballColor = _getColor(context);
    final holderThick =
        _getHolderThick(widgetWidth, widgetHeight, widget.holderThick);
    final ropeWithBallHeight =
        _getRopeHeight(widgetHeight, holderThick, widget.message != null);
    final rotateSpace = _getRotateSpace(ropeWithBallHeight, rotateAngle);
    final ballsNum = _getBallsNum(widgetWidth);
    final ballSize = _getBallSize(ropeWithBallHeight,
        widgetWidth - (holderThick * 2), rotateSpace, ballsNum);
    ///////////////////////////////////////////////////////////////////////////////////done
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: widgetHeight,
          width: widgetWidth,
          child: Column(
            children: [
              HorizontalHolder(height: holderThick),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalHolder(width: holderThick),
                      const Spacer(),
                      AnimatedBall(
                        clockwise: true,
                        mainColor: ballColor,
                        animation: _animation,
                        ballSize: ballSize,
                        threadColor: widget.threadColor,
                        // playSound: widget.wantHitSound,
                      ),
                      ...List<Widget>.generate(
                          ballsNum - 2,
                          (_) => ConstBall(
                                ballColor: ballColor,
                                ballSize: ballSize,
                                threadColor: widget.threadColor,
                              )),
                      AnimatedBall(
                        clockwise: false,
                        mainColor: ballColor,
                        ballSize: ballSize,
                        animation: _animation,
                        threadColor: widget.threadColor,
                        // // playSound: widget.wantHitSound,
                        // playSound:
                        //     false, //only one AnimatedBall will run the sound
                      ),
                      const Spacer(),
                      VerticalHolder(width: holderThick),
                    ],
                  ),
                ),
              ),
              if (widget.message != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.message!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double _getRopeHeight(
      double widgetHeight, double holderThick, bool thereLoadingMessage) {
    //52 is
    // 8*2(widget padding from top and bottom)
    // +8 ball padding from button
    // +8 text padding from top
    // +20 text height
    return widgetHeight - (thereLoadingMessage ? 52 : 24) - holderThick;
  }

  double _getWidth(BuildContext context) {
    return widget.widgetSize?.width ?? MediaQuery.sizeOf(context).width / 2;
  }

  double _getBallSize(
    double widgetHeight,
    double widgetWidth,
    double rotateSpace,
    int ballsNum,
  ) {
    if (widget.ballSize != null) {
      return widget.ballSize!;
    }
    //rotate space *2 for both animated balls in left and right
    final maximumBallsWidth = widgetWidth - rotateSpace * 2;
    if (maximumBallsWidth < 10 * ballsNum) {
      return 10; //minimalist
    }
    final ballWidth = maximumBallsWidth / ballsNum;
    if (ballWidth > widgetHeight / 3.5) {
      return widgetHeight / 3.5; //to look beautiful
    }
    if (ballWidth > 35) {
      return 35; //big enough
    }
    return ballWidth;
  }

  Color _getColor(BuildContext context) {
    if (widget.mainColor != null) {
      return widget.mainColor!;
    }
    if (Theme.of(context).brightness == Brightness.light) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.inversePrimary;
  }

  int _getBallsNum(double width) {
    if (width > 300) {
      return 5;
    }
    if (width > 200) {
      return 4;
    }
    return 3;
  }

  _getRotateSpace(double ropeWithBallHeight, double rotateAngle) {
    return ropeWithBallHeight * sin(rotateAngle);
  }

  _getHolderThick(
      double widgetWidth, double widgetHeight, double? holderThick) {
    if (holderThick != null) {
      return holderThick;
    }
    final possibleThick = widgetWidth / 40;
    if (possibleThick < widgetHeight / 15) {
      return possibleThick;
    } else {
      return widgetHeight / 15;
    }
  }

  void _initRotateAnimation(double rotationDegree) {
    rotateAngle = rotationDegree * pi / 180;
    _animation = Tween<double>(begin: -(rotateAngle), end: (rotateAngle))
        .animate(_controller);
  }
}
