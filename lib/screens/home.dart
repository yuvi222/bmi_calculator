import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bmi_calculator/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets/left_bar.dart';
import 'package:bmi_calculator/widgets/right_bar.dart';
import 'package:bmi_calculator/constants/app_constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmiResult = 0;
  String _textResult = "";
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _heightController.clear();
      _weightController.clear();
      _textResult = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'BMI Calculator',
              textStyle: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 1000),
            ),
          ],
          totalRepeatCount: 4,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
        // Text(
        //   "BMI Calculator",
        //   style: TextStyle(color: accentHexColor, fontWeight: FontWeight.w300),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: mainHexColor,
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: Colors.black,
        height: 300,
        backgroundColor: accentHexColor,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 130,
                        child: TextField(
                          controller: _heightController,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: accentHexColor,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Height",
                            hintStyle: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: TextField(
                          controller: _weightController,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w300,
                            color: accentHexColor,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Weight",
                            hintStyle: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      double h = double.parse(_heightController.text);
                      double w = double.parse(_weightController.text);
                      setState(() {
                        _bmiResult = w / (h * h / 10000);
                        if (_bmiResult > 25) {
                          _textResult = "You are over weight";
                        } else if (_bmiResult >= 18.5 && _bmiResult <= 25) {
                          _textResult = "You have normal weight";
                        } else {
                          _textResult = "You are under weight";
                        }
                      });
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: accentHexColor),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Visibility(
                    visible: _textResult.isNotEmpty,
                    child: Text(
                      _bmiResult.toStringAsFixed(2),
                      style: TextStyle(fontSize: 90, color: accentHexColor),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: _textResult.isNotEmpty,
                    child: Text(
                      _textResult,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: accentHexColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LeftBar(barWidth: 70),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      CircleBar(circleWidth: 25, circleHeigth: 25, radius: 50),
                      SizedBox(width: 5),
                      LeftBar(barWidth: 150),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const LeftBar(barWidth: 70),
                  const SizedBox(height: 20),
                  const RightBar(barWidth: 70),
                  const SizedBox(height: 50),
                  const RightBar(barWidth: 200),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SpinKitWave(
                          size: 50,
                          color: accentHexColor,
                          type: SpinKitWaveType.center,
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 30),
                  //   child: CircleBar(circleWidth: 80, circleHeigth: 50, radius: 50),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
