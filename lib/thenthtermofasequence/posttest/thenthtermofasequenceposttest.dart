import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThenthtermofasequenceposttestviewPage extends StatefulWidget {
  const ThenthtermofasequenceposttestviewPage({super.key});

  @override
  _ThenthtermofasequenceposttestviewPage createState() =>
      _ThenthtermofasequenceposttestviewPage();
}

class _ThenthtermofasequenceposttestviewPage
    extends State<ThenthtermofasequenceposttestviewPage> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  String status = 'pending';

  Map<int, String> _selectedAnswers =
      {}; // Map to store selected answers by question index

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "What is the nth term of the sequence defined by an = 1 + (n - 1) x 5?",
      "options": ["5n - 4", "6n - 5", "4n + 1", "5n + 2"],
      "answer": "5n - 4"
    },
    {
      "question": "What is a sequence?",
      "options": [
        "A random list of numbers",
        "A list of numbers arranged in a specific order",
        "A single number",
        "A pattern of letters"
      ],
      "answer": "A list of numbers arranged in a specific order"
    },
    {
      "question":
          "What is the nth term of the arithmetic sequence: 15, 20, 25, 30?",
      "options": [
        "an = 15 + 5(n - 1)",
        "an = 20n",
        "an = 25 - 5(n - 1)",
        "an = 15 + 5n"
      ],
      "answer": "an = 15 + 5(n - 1)"
    },
    {
      "question": "Which of the following sequences is geometric?",
      "options": ["2, 5, 10, 15", "2, 3, 5, 7", "3, 6, 9, 12", "1, 2, 4, 8"],
      "answer": "1, 2, 4, 8"
    },
    {
      "question":
          "What is the 3rd term of the geometric sequence defined by an = 5 * 4^(n-1)?",
      "options": ["5", "20", "80", "160"],
      "answer": "80"
    },
    {
      "question":
          "Which of the following correctly represents the nth term of the sequence 3, 6, 9, 12, ...?",
      "options": [
        "an = 3n",
        "an = 3 + (n - 1) x 3",
        "an = 3 + (n - 1) x 2",
        "an = 3n + 3"
      ],
      "answer": "an = 3 + (n - 1) x 3"
    },
    {
      "question":
          "What is the common ratio in the geometric sequence 2, 6, 18, 54?",
      "options": ["2", "3", "4", "5"],
      "answer": "3"
    },
    {
      "question":
          "What is the nth term of the geometric sequence 5, 15, 45, 135?",
      "options": [
        "an = 5 x 3^(n-1)",
        "an = 5 x 2^(n-1)",
        "an = 3^(n-1)",
        "an = 5 + (n-1) x 15"
      ],
      "answer": "an = 5 x 3^(n-1)"
    },
    {
      "question":
          "For the geometric sequence defined by the formula an = 3 x 2^(n-1), what is the second term (n = 2)?",
      "options": ["3", "6", "9", "12"],
      "answer": "6"
    },
    {
      "question":
          "In the arithmetic sequence defined by the formula an = 2 + (n - 1) x 3, what is the first term (n = 1)?",
      "options": ["5", "3", "2", "6"],
      "answer": "2"
    },
    {
      "question":
          "What is the formula for the nth term of an arithmetic sequence?",
      "options": [
        "an = a + (n - 1)d",
        "an = a x d^n",
        "an = a + nd",
        "an = d + n"
      ],
      "answer": "an = a + (n - 1)d"
    },
    {
      "question": "Which of the following is an arithmetic sequence?",
      "options": [
        "1, 2, 4, 8, 16",
        "3, 6, 9, 12, 15",
        "2, 4, 8, 16",
        "1, 1, 2, 3, 5"
      ],
      "answer": "3, 6, 9, 12, 15"
    },
    {
      "question":
          "What is the 5th term of the arithmetic sequence defined by an = 2 + (n - 1) x 5?",
      "options": ["25", "20", "22", "15"],
      "answer": "20"
    },
    {
      "question":
          "If the nth term of a sequence is given by an = 4 * 2^(n-1), which of the following is true?",
      "options": [
        "It’s an arithmetic sequence.",
        "It’s a geometric sequence.",
        "It’s a constant sequence.",
        "It has no first term."
      ],
      "answer": "It’s a geometric sequence."
    },
    {
      "question":
          "What is the nth term of the arithmetic sequence 4, 7, 10, 13?",
      "options": ["4n", "3n + 1", "3n + 4", "3n + 2"],
      "answer": "3n + 1"
    },
    {
      "question":
          "If a geometric sequence has a first term of 1 and a common ratio of 3, what is the formula for the nth term?",
      "options": [
        "an = 3^(n-1)",
        "an = 1 x 3^(n-1)",
        "an = 1 + 3^(n-1)",
        "an = 3 + 3^(n-1)"
      ],
      "answer": "an = 1 x 3^(n-1)"
    },
    {
      "question":
          "What is the common difference in the arithmetic sequence 5, 10, 15, 20?",
      "options": ["5", "10", "15", "20"],
      "answer": "5"
    },
    {
      "question":
          "What is the first term of the sequence defined by an = 10 + (n - 1) x 2?",
      "options": ["8", "12", "10", "14"],
      "answer": "10"
    },
    {
      "question":
          "If the first term of a geometric sequence is 4 and the common ratio is 2, what is the 4th term?",
      "options": ["8", "16", "64", "32"],
      "answer": "32"
    },
    {
      "question":
          "For the arithmetic sequence 8, 12, 16, 20, what is the common difference?",
      "options": ["2", "4", "6", "10"],
      "answer": "4"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('thenthtermofasequenceposttestscore') ??
          0; // Load saved score
      correctAnswers =
          prefs.getStringList('thenthtermofasequenceposttestcorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('thenthtermofasequenceposttestsavedQuestions') ??
              []; // Load saved questions
      status = prefs.getString('thenthtermofasequenceposttestCompleted') ?? '';
    });

    // Filter out questions that are already saved
    questions.removeWhere(
        (question) => savedQuestions.contains(question['question']));
  }

  Future<void> _saveSelectedAnswer(String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the selected answer is correct
    if (answer == questions[currentQuestionIndex]['answer']) {
      // Avoid duplicate scoring for the same question
      if (!correctAnswers
          .contains(questions[currentQuestionIndex]['question'])) {
        correctAnswers.add(
            questions[currentQuestionIndex]['question']); // Track the question
        score++; // Increase score
        await prefs.setStringList('thenthtermofasequenceposttestcorrectAnswers',
            correctAnswers); // Save correct answers
        await prefs.setInt(
            'thenthtermofasequenceposttestscore', score); // Save score
      }
    } else {
      // Handle case where the answer changes from correct to incorrect
      if (correctAnswers
          .contains(questions[currentQuestionIndex]['question'])) {
        correctAnswers.remove(questions[currentQuestionIndex]
            ['question']); // Remove from correct answers
        score--; // Decrease score
        await prefs.setStringList('thenthtermofasequenceposttestcorrectAnswers',
            correctAnswers); // Save updated correct answers
        await prefs.setInt(
            'thenthtermofasequenceposttestscore', score); // Save updated score
      }
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('thenthtermofasequenceposttestsavedQuestions',
        savedQuestions); // Save to local storage

    // Check if it's the last question
    if (currentQuestionIndex == questions.length - 1) {
      // If it's the last question, print the final score
      print("Score: $score");

      // Mark the test as completed if the score is 15 or above
      if (score >= 15) {
        await prefs.setString(
            'thenthtermofasequenceposttestCompleted', 'completed');
      }

      // Navigate to the results page or handle end of quiz here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ThenthtermofasequenceposttestviewPage(),
        ),
      );
    } else {
      // If not the last question, wait for the user to press next manually
      print("Score: $score"); // Print the current score
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'thenthtermofasequenceposttestsavedQuestions'); // Clear savedQuestions from local storage
    setState(() {
      savedQuestions.clear(); // Clear the savedQuestions list in the app
      // Optionally, you can also reset other related state variables if needed
    });
  }

  Future<void> _resetQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the saved data in SharedPreferences
    await prefs.remove('thenthtermofasequenceposttestscore');
    await prefs.remove('thenthtermofasequenceposttestcorrectAnswers');
    await prefs.remove('thenthtermofasequenceposttestsavedQuestions');
    await prefs.remove('thenthtermofasequenceposttestCompleted');

    // Reset state variables
    setState(() {
      score = 0;
      correctAnswers.clear();
      savedQuestions.clear();
      currentQuestionIndex = 0;
      _selectedAnswer = null;
      status = 'pending';
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2.1;

    // Check if there are available questions after filtering
    bool hasQuestions = questions.isNotEmpty;

    // Check if quiz is completed or showing the score
    bool isQuizCompleted = currentQuestionIndex >= questions.length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2F6609), Color(0xFFC1FFB1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                  color: status == 'pending'
                      ? Color(0xFF2F6609)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    if (!isQuizCompleted)
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 20),
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          child: FaIcon(FontAwesomeIcons.arrowLeft,
                              color: Colors.white),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(221, 48, 102, 9),
                                          Color.fromARGB(238, 48, 102, 9)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 30),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Confirm to exit?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const WelcomePage()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF2F6609),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(
                                                    'YES',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF2F6609),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(
                                                    'NO',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 20),
                    score < 15
                        ? Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          )
                        : SizedBox(),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: hasQuestions
                                  ? "${currentQuestionIndex + 1}. ${questions[currentQuestionIndex]['question']}\n"
                                  : "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                hasQuestions
                    ? "Question ${currentQuestionIndex + 1}/ ${questions.length}"
                    : "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: hasQuestions
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount:
                              questions[currentQuestionIndex]['options'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAnswer =
                                      questions[currentQuestionIndex]['options']
                                          [index];
                                  _selectedAnswers[currentQuestionIndex] =
                                      _selectedAnswer!; // Save the selected answer
                                });
                                _saveSelectedAnswer(_selectedAnswer!);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: _selectedAnswer ==
                                          questions[currentQuestionIndex]
                                              ['options'][index]
                                      ? Colors.lightGreen
                                      : Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/quiz.png'),
                                      width: 50,
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        questions[currentQuestionIndex]
                                            ['options'][index],
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    )),
                                    SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Column(
                        children: [
                          Image(
                            image: AssetImage('assets/trophy.png'),
                            width: 200,
                          ),
                          if (score >= 15)
                            Text(
                              'Very Good!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (score < 15)
                            Text(
                              'Good!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (score >= 15)
                            Text(
                              'You have passed the test!',
                              style: TextStyle(
                                  color: Color(0xFF2F6609),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Your score is!',
                            style: TextStyle(
                                color: Color(0xFF2F6609),
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${score}/20',
                            style: TextStyle(
                                color: Color(0xFF2F6609),
                                fontSize: 35,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F6609),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await _resetQuiz(); // Call the reset function
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ThenthtermofasequenceposttestviewPage()));
                              },
                              child: const Text(
                                'Retake',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 47),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F6609),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomePage()),
                                );
                              },
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
              ),
              if (!isQuizCompleted) // Only show the buttons when the quiz is not completed
                SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Back Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: Color(0xFF2F6609),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (currentQuestionIndex > 0) {
                                currentQuestionIndex--;
                                _selectedAnswer =
                                    _selectedAnswers[currentQuestionIndex] ??
                                        null; // Restore the previous answer
                              }
                            });
                          },
                          child: Text(
                            '< Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),

                      // Next Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: Color(0xFF2F6609),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (currentQuestionIndex < questions.length - 1) {
                                currentQuestionIndex++;
                                _selectedAnswer =
                                    _selectedAnswers[currentQuestionIndex] ??
                                        null; // Restore the previous answer
                              }
                            });
                          },
                          child: Text(
                            'Next > ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
