import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/algebraicequation.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Understandingalgebraicequation1 extends StatefulWidget {
  const Understandingalgebraicequation1({super.key});

  @override
  State<Understandingalgebraicequation1> createState() =>
      _Understandingalgebraicequation1State();
}

class _Understandingalgebraicequation1State
    extends State<Understandingalgebraicequation1> {
  late CustomVideoPlayerController _controller;

  String videopath = "assets/Algebraic_Equation1.mp4";

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
      mark = prefs.getString('mark4') ?? 'unmark';
    });
  }

// Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark4', mark);
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Stack with video player and back button
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
                                    const AlgebraicEquationPage()));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Content below the video player
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 15),
                  // Title and Bookmark button
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Algebraic Equation',
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
                  // Divider
                  Container(
                    width: double.infinity,
                    height: 2,
                    decoration: BoxDecoration(border: Border.all(width: 3)),
                  ),
                  SizedBox(height: 15),
                  // Content
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Topic: Translating Word Phrases into Algebraic Equations and Vice Versa',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Introduction to Algebraic Concepts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• What is Algebra?\n'
                          '  o Algebra uses symbols and letters to represent numbers and quantities in mathematical statements.\n'
                          '• Importance of Translation:\n'
                          '  o Being able to switch between words and algebraic symbols helps solve problems and understand relationships.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Translating Word Phrases into Algebraic Equations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Key Terms and Their Translations:\n'
                          '  o Sum: Addition (e.g., "the sum of x and 5" → x + 5)\n'
                          '  o Difference: Subtraction (e.g., "the difference of x and 3" → x − 3)\n'
                          '  o Product: Multiplication (e.g., "the product of 4 and x" → 4x)\n'
                          '  o Quotient: Division (e.g., "the quotient of x and 2" → x / 2)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example Problem:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        Text(
                          'Phrase: "The sum of a number and 8 is 15."\n'
                          '  o Variable: Let x be the number.\n'
                          '  o Translation: x + 8 = 15',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Translating Word Phrases',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        Text(
                          'Translate the Following Phrases:\n'
                          '• "Three times a number equals 12."\n'
                          '• "A number decreased by 5 is 10."\n'
                          '• "The sum of a number and 9 is 20."\n'
                          '• "Five more than twice a number is 18."',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Translating Algebraic Equations into Word Phrases',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example Problem:\n'
                          '• Equation: 3x − 4 = 11\n'
                          '• Translation: "Three times a number decreased by four equals eleven."',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Practice: Translating Equations into Word Phrases',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F6609),
                          ),
                        ),
                        Text(
                          '• x + 7 = 14\n'
                          '• 5x = 25\n'
                          '• 2x − 3 = 9\n'
                          '• 4 + x = 12',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
