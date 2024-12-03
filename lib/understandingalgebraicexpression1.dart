import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/algebraicexpression.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Understandingalgebraicexpression1 extends StatefulWidget {
  const Understandingalgebraicexpression1({super.key});

  @override
  State<Understandingalgebraicexpression1> createState() =>
      _Understandingalgebraicexpression1State();
}

class _Understandingalgebraicexpression1State
    extends State<Understandingalgebraicexpression1> {
  late CustomVideoPlayerController _controller;

  String videopath = "assets/Algebraic_Expression1.mp4";

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    _loadBookmarkStatus();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String mark = "unmark";

// Load bookmark status from local storage
  Future<void> _loadBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = prefs.getString('mark3') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark3', mark);
  }

  void initializeVideoPlayer() {
    VideoPlayerController _videoPlayerController;
    _videoPlayerController = VideoPlayerController.asset(videopath)
      ..initialize().then((value) {
        setState(() {});
      });
    _controller = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoPlayerController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                CustomVideoPlayer(
                  customVideoPlayerController: _controller,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (mark == 'mark') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()));
                      } else if (mark == 'unmark') {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AlgebraicExpressionPage()));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Algebraic Expression',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Center(
                          child: SizedBox(
                              width: 50,
                              child: GestureDetector(
                                child: FaIcon(
                                  mark == "mark"
                                      ? FontAwesomeIcons.solidBookmark
                                      : FontAwesomeIcons.bookmark,
                                  color: Color(0xFF2F6609),
                                ),
                                onTap: _toggleBookmark,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 2,
                    decoration: BoxDecoration(border: Border.all(width: 3)),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Understanding Algebraic Expressions',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Introduction to Algebraic Expressions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• An algebraic expression is a combination of numbers, variables, and operation symbols without an equal sign. These expressions are fundamental in algebra for computations and problem-solving.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Components of an Algebraic Expression',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Constants: Fixed numbers, e.g., 5, -3, 7.2\n'
                          '• Variables: Symbols representing unknown values, e.g., x, y, z\n'
                          '• Coefficients: Numbers that multiply variables, e.g., in 3x, 3 is the coefficient\n'
                          '• Operators: Symbols indicating operations, e.g., +, −, *, /',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Examples of Algebraic Expressions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Expression 1: 3x + 2\n'
                          '  o Coefficient: 3\n'
                          '  o Variable: x\n'
                          '  o Operator: +\n'
                          '  o Constant: 2\n'
                          '• Expression 2: 4y - 7\n'
                          '  o Coefficient: 4\n'
                          '  o Variable: y\n'
                          '  o Operator: -\n'
                          '  o Constant: 7',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Types of Algebraic Expressions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Monomial: One term (e.g., 5x)\n'
                          '• Binomial: Two terms (e.g., 3x + 2)\n'
                          '• Trinomial: Three terms (e.g., 2x^2 + 3x + 5)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Common Keywords and Their Meanings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Phrase                        Operation\n'
                          'Sum of                       Addition (+)\n'
                          'Difference of                Subtraction (−)\n'
                          'Product of                   Multiplication (×)\n'
                          'Quotient of                  Division (÷)\n'
                          'Is equal to                  Equals (=)\n'
                          'More than                    Addition (+)\n'
                          'Less than                    Subtraction (−)\n'
                          'Twice a number               Multiplication by 2 (×2)\n'
                          'Three times a number         Multiplication by 3 (×3)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Translating Phrases into Algebraic Expressions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Steps to Translate:\n'
                          '• Identify Keywords\n'
                          '• Assign a Variable\n'
                          '• Combine Elements',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Examples of Translation\n'
                          'Example 1: "The sum of a number and 8" -> x + 8\n'
                          'Example 2: "Five less than a number" -> y - 5\n'
                          'Example 3: "Three times a number increased by 4" -> 3z + 4',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Practice Questions\n'
                          '• Difference between a number and 10: x - 10\n'
                          '• Product of 6 and a number: 6y\n'
                          '• Number divided by 2: z / 2\n'
                          '• Eight more than twice a number: 2x + 8\n'
                          '• Sum of a number and 12 is 20: x + 12',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
