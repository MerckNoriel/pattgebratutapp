import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/thenthtermofasequence.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnderstandingthenthtermofasequencePage1 extends StatefulWidget {
  const UnderstandingthenthtermofasequencePage1({super.key});

  @override
  State<UnderstandingthenthtermofasequencePage1> createState() =>
      _UnderstandingthenthtermofasequencePage1State();
}

class _UnderstandingthenthtermofasequencePage1State
    extends State<UnderstandingthenthtermofasequencePage1> {
  late CustomVideoPlayerController _controller;

  String videopath = "assets/Nth_Term_of_a_Sequence.mp4";

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
      mark = prefs.getString('mark2') ?? 'unmark';
    });
  }

  // Toggle bookmark status and save to local storage
  Future<void> _toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mark = (mark == "mark") ? "unmark" : "mark";
    });
    prefs.setString('mark2', mark);
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
                                    const ThenthtermofasequencePage()));
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
                          'The Nth Term of a Sequence',
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
                          'Topic: The Nth Term of a Sequence',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Introduction to Sequences',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Definition: A sequence is a list of numbers arranged in a specific order.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• Types of Sequences:\n'
                          '  o Arithmetic Sequence: Each term is the previous term plus a constant (common difference).\n'
                          '  o Geometric Sequence: Each term is the previous term multiplied by a constant (common ratio).',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Understanding the Nth Term',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• What is the Nth Term?\n'
                          '  o The nth term is a formula that allows you to find any term in a sequence without listing all the terms.',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:\n'
                          '• For the sequence 2, 4, 6, 8, ... (an arithmetic sequence):\n'
                          '  o The first term (n = 1) is 2.\n'
                          '  o The second term (n = 2) is 4.\n'
                          '  o The rule can be expressed as: an = 2n',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Finding the Nth Term in Arithmetic Sequences',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• General Formula:\n'
                          '  o For an arithmetic sequence: an = a + (n − 1) d\n'
                          '• Where:\n'
                          '  o a = first term\n'
                          '  o d = common difference\n'
                          '  o n = term number',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:\n'
                          '• Sequence: 3, 7, 11, 15, ...\n'
                          '  o First term a = 3\n'
                          '  o Common difference d = 4\n'
                          '  o Nth term formula: an = 3 + (n − 1) × 4\n'
                          '  o Simplified: an = 4n − 1',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Finding the Nth Term in Geometric Sequences',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '• General Formula:\n'
                          '  o For a geometric sequence: an = a ⋅ r^(n−1)\n'
                          '• Where:\n'
                          '  o a = first term\n'
                          '  o r = common ratio\n'
                          '  o n = term number',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Example:\n'
                          '• Sequence: 2, 6, 18, 54, ...\n'
                          '  o First term a = 2\n'
                          '  o Common ratio r = 3\n'
                          '  o Nth term formula: an = 2 ⋅ 3^(n−1)',
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
