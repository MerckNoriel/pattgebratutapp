import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class UnderstandingthenthtermofasequencePage extends StatefulWidget {
  const UnderstandingthenthtermofasequencePage({super.key});

  @override
  _UnderstandingthenthtermofasequencePage createState() =>
      _UnderstandingthenthtermofasequencePage();
}

class _UnderstandingthenthtermofasequencePage
    extends State<UnderstandingthenthtermofasequencePage> {
  late VideoPlayerController _controller;
  void initState() {
    super.initState();
    // Initialize the video player controller with a video URL
    _controller =
        VideoPlayerController.asset('assets/Nth_Term_of_a_Sequence.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized
            setState(() {});
          });
    _loadBookmarkStatus();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: _controller.value.isInitialized
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      : CircularProgressIndicator(), // Show a loading indicator until the video is initialized
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(children: [
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
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Types of Sequences:\n'
                      '  o Arithmetic Sequence: Each term is the previous term plus a constant (common difference).\n'
                      '  o Geometric Sequence: Each term is the previous term multiplied by a constant (common ratio).',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Example:\n'
                      '• For the sequence 2, 4, 6, 8, ... (an arithmetic sequence):\n'
                      '  o The first term (n = 1) is 2.\n'
                      '  o The second term (n = 2) is 4.\n'
                      '  o The rule can be expressed as: an = 2n',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Example:\n'
                      '• Sequence: 3, 7, 11, 15, ...\n'
                      '  o First term a = 3\n'
                      '  o Common difference d = 4\n'
                      '  o Nth term formula: an = 3 + (n − 1) × 4\n'
                      '  o Simplified: an = 4n − 1',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
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
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Example:\n'
                      '• Sequence: 2, 6, 18, 54, ...\n'
                      '  o First term a = 2\n'
                      '  o Common ratio r = 3\n'
                      '  o Nth term formula: an = 2 ⋅ 3^(n−1)',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2F6609)),
                    ),
                  ],
                ),
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
