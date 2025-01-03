import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/solvingequation.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Understandingsolvingequation1 extends StatefulWidget {
  const Understandingsolvingequation1({super.key});

  @override
  State<Understandingsolvingequation1> createState() =>
      _Understandingsolvingequation1State();
}

class _Understandingsolvingequation1State
    extends State<Understandingsolvingequation1> {
  late CustomVideoPlayerController _controller;

  String videopath = "assets/Solving_Equation1.mp4";

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
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  String mark = "unmark";

// Load bookmark status from local storage
  Future<void> _loadBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = prefs.getString('mark5') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark5', mark);
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
                                    const SolvingEquationPage()));
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
                          'Solving Equation',
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
                            ),
                          ),
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
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Topic: Translating Verbal Phrases into Equations and Solving Equation',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Understanding Verbal Phrases',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• What are Verbal Phrases?\n'
                          '  o Verbal phrases are statements or sentences that describe a mathematical relationship using words. We can translate these phrases into equations.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Common Keywords',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Here are some common phrases and their mathematical representations:\n'
                          'Phrase                    Mathematical Operation\n'
                          '• Sum of                 Addition (+)\n'
                          '• Difference of          Subtraction (−)\n'
                          '• Product of             Multiplication (×)\n'
                          '• Quotient of            Division (÷)\n'
                          '• Is equal to            Equals (=)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Translating Phrases into Equations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Steps to Translate:\n'
                          '• Identify the Keywords: Look for keywords in the phrase.\n'
                          '• Assign a Variable: Let x represent the unknown number.\n'
                          '• Write the Equation: Combine the variable and constants using the appropriate operations.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example: Translate and Write an Equation\n'
                          '• Phrase: "The sum of a number and 8 is 15."\n'
                          'Step-by-Step Translation:\n'
                          '• Identify Keywords: "Sum of" indicates addition, and "is" indicates equals.\n'
                          '• Assign a Variable: Let x be the unknown number.\n'
                          'Write the Equation:\n'
                          '• x + 8 = 15',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Solving the Equation',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Steps to Solve an Equation:\n'
                          '• Isolate the Variable: Use inverse operations to get the variable alone on one side of the equation.\n'
                          '• Perform the Operations: Do the same operation on both sides to keep the equation balanced.\n'
                          '• Check Your Solution: Substitute your answer back into the original equation to verify.\n'
                          'Example: Solve the Equation\n'
                          '• Equation: x + 8 = 15\n'
                          'Step-by-Step Solution:\n'
                          'Isolate the Variable: Subtract 8 from both sides:\n'
                          '• x + 8 − 8 = 15 − 8\n'
                          'x = 7\n'
                          'Check Your Solution: Substitute x = 7 back into the equation:\n'
                          '• 7 + 8 = 15 (True)\n'
                          'Final Solution:\n'
                          '• x = 7',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Solving Equations with Basic Operations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'What is an Equation?\n'
                          '• An equation is a mathematical statement that two expressions are equal and often contains a variable (an unknown number).\n'
                          'Example: x + 4 = 10\n'
                          'Components of an Equation:\n'
                          '• Variable: A letter representing an unknown value (x).\n'
                          '• Constant: A fixed number (5).\n'
                          '• Coefficient: A number multiplied by a variable (in 3x, 3 is the coefficient).\n'
                          '• Operator: Symbols that indicate mathematical operations (+, -, ×, ÷).',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'The Four Basic Operations:\n'
                          '• Addition (+): Combining two or more numbers.\n'
                          '• Subtraction (−): Taking one number away from another.\n'
                          '• Multiplication (×): Adding a number to itself a certain number of times.\n'
                          '• Division (÷): Splitting a number into equal parts.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Solving One-step Equations:\n'
                          'Example: Solve x + 5 = 12 using addition and subtraction.\n'
                          '• Step 1: Identify the operation. Here, 5 is added to x.\n'
                          '• Step 2: Use subtraction to isolate x:\n'
                          'x + 5 − 5 = 12 − 5\n'
                          'x = 7\n'
                          'Check Method:\n'
                          '• Substitute x = 7 back into the original equation:\n'
                          '7 + 5 = 12 (True)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Solving Two-step Equations:\n'
                          'Example: Solve 2x + 4 = 12.\n'
                          '• Step 1: Subtract 4 from both sides:\n'
                          '2x + 4 − 4 = 12 − 4\n'
                          '2x = 8\n'
                          '• Step 2: Divide by 2:\n'
                          '2x / 2 = 8 / 2\n'
                          'x = 4\n'
                          'Check Method:\n'
                          '• Substitute x = 4 back into the original equation:\n'
                          '2(4) + 4 = 12 (True)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Solving Multi-step Equations:\n'
                          'Example: Solve 3(x + 2) – 4 = 11.\n'
                          '• Step 1: Distribute 3:\n'
                          '3x + 6 – 4 = 11\n'
                          '• Step 2: Combine like terms:\n'
                          '3x + 2 = 11\n'
                          '• Step 3: Subtract 2:\n'
                          '3x + 2 – 2 = 11 − 2\n'
                          '3x = 9\n'
                          '• Step 4: Divide by 3:\n'
                          'x = 9 / 3\n'
                          'x = 3\n'
                          'Check Method:\n'
                          '• Substitute x = 3 back into the original equation:\n'
                          '3(3 + 2) – 4 = 11 (True)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
