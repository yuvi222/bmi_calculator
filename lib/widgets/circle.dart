import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants/app_constant.dart';

class CircleBar extends StatelessWidget {
  final double circleWidth;
  final double circleHeigth;
  final double radius;
  const CircleBar(
      {Key? key,
      required this.circleWidth,
      required this.circleHeigth,
      required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: circleHeigth,
          width: circleWidth,
          decoration: BoxDecoration(
            color: accentHexColor,
            borderRadius: BorderRadius.circular(radius),
          ),
        )
      ],
    );
  }
}
