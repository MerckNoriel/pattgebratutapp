import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/fibonaccisequence.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnderstandingfibonaccisequencePage1 extends StatefulWidget {
  const UnderstandingfibonaccisequencePage1({super.key});

  @override
  State<UnderstandingfibonaccisequencePage1> createState() =>
      _UnderstandingfibonaccisequencePage1State();
}

class _UnderstandingfibonaccisequencePage1State
    extends State<UnderstandingfibonaccisequencePage1> {
  late CustomVideoPlayerController _controller;

  String videopath = "assets/Fibonacci_Sequence1.mp4";

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
      mark = prefs.getString('mark1') ?? 'unmark';
    });
  }

  // Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark1', mark);
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
            // Stack with video and back button
            Stack(
              children: [
                // Video Player
                CustomVideoPlayer(
                  customVideoPlayerController: _controller,
                ),
                // Positioned Back Button
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
                                    const FibonacciSequencePage()));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Content Below the Video
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
                          'Fibonacci Sequence',
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
                          'Introduction to Pascal\'s Triangle',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'What is Pascal\'s Triangle?',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• A triangular arrangement of numbers where each number is the sum of the two above it.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'How to Build It:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Start with 1 at the top.\n• Each number below is created by adding the two numbers above it.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Image(image: AssetImage('assets/i1.png')),
                        SizedBox(height: 16),
                        Text(
                          'Introduction to the Fibonacci Sequence',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'What is the Fibonacci Sequence?',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• A series of numbers where each number is the sum of the two preceding ones.\n'
                          '• Starting Numbers: 0, 1, 1, 2, 3, 5, 8, 13...',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Connecting Fibonacci and Pascal\'s Triangle',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'How to Find Fibonacci Numbers:\n'
                          '• Look at the diagonals in Pascal\'s Triangle and sum the numbers.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:\n'
                          'Diagonal 1: 1 (1st Fibonacci number)\n'
                          'Diagonal 2: 1 (2nd Fibonacci number)\n'
                          'Diagonal 3: 2 (3rd Fibonacci number)\n'
                          'Diagonal 4: 3 (4th Fibonacci number)\n'
                          'Diagonal 5: 5 (5th Fibonacci number)',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Exploring Fibonacci Sequence with Basic Operation',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Introduction to the Fibonacci Sequence',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Definition: A sequence of numbers where each number is the sum of the two preceding numbers.\n'
                          '• Starting Numbers: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Building the Fibonacci Sequence',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• How to Generate the Sequence:\n'
                          '  • Start with 0 and 1.\n'
                          '  • Add the last two numbers to get the next one.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:\n'
                          'Start: 0, 1\n'
                          'Next: 0 + 1 = 1\n'
                          'Next: 1 + 1 = 2\n'
                          'Next: 1 + 2 = 3\n'
                          'Continue this pattern...',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Basic Operations with Fibonacci Numbers',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Addition:\n'
                          '  • Add two Fibonacci numbers together.\n'
                          '  • Example: 5 + 8 = 13\n'
                          '• Subtraction:\n'
                          '  • Subtract one Fibonacci number from another.\n'
                          '  • Example: 13 – 8 = 5\n'
                          '• Multiplication:\n'
                          '  • Multiply two Fibonacci numbers.\n'
                          '  • Example: 5 × 3 = 15\n'
                          '• Division:\n'
                          '  • Divide one Fibonacci number by another.\n'
                          '  • Example: 21 ÷ 3 = 7',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
