import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Algebraicequationposttestview extends StatefulWidget {
  const Algebraicequationposttestview({super.key});

  @override
  _Algebraicequationposttestview createState() =>
      _Algebraicequationposttestview();
}

class _Algebraicequationposttestview
    extends State<Algebraicequationposttestview> {
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
      "question": "What does the equation x + 5 = 15 translate to?",
      "options": [
        "The sum of five and a number is fifteen.",
        "A number plus five equals fifteen.",
        "Five more than a number is fifteen",
        "Fifteen minus five equals a number."
      ],
      "answer": "Five more than a number is fifteen"
    },
    {
      "question": "Translate: The product of a number and 7 is 42.",
      "options": ["42 - 7x = 0", "x + 7 = 42", "7x = 42", "7 - x = 42"],
      "answer": "7x = 42"
    },
    {
      "question": "What does the equation 8 + x = 24 mean?",
      "options": [
        "Twenty-four minus eight equals a number.",
        "A number plus eight equals twenty-four.",
        "The sum of eight and a number is twenty-four.",
        "Eight more than a number equals twenty-four"
      ],
      "answer": "Eight more than a number equals twenty-four"
    },
    {
      "question": "Translate: Three less than twice a number is 9.",
      "options": ["2x - 3 = 9", "3 - 2x = 9", "2 - 3x = 9", "x - 3 = 9"],
      "answer": "2x - 3 = 9"
    },
    {
      "question": "Translate: The quotient of a number and 6 is 2.",
      "options": ["x + 6 = 2", "x / 6 = 2", "6 - x = 2", "2 / x = 6"],
      "answer": "x / 6 = 2"
    },
    {
      "question": "Translate: A number divided by 3 equals 9.",
      "options": ["x + 3 = 9", "x / 3 = 9", "3 - x = 9", "9 / x = 3"],
      "answer": "x / 3 = 9"
    },
    {
      "question": "What does the equation 5x - 15 = 10 translate to?",
      "options": [
        "Fifteen less than five times a number is ten.",
        "Five times a number decreased by fifteen equals ten",
        "The difference of five times a number and fifteen is ten.",
        "Ten more than five times a number is fifteen."
      ],
      "answer": "Five times a number decreased by fifteen equals ten"
    },
    {
      "question": "What does the equation 20 - x = 5 mean?",
      "options": [
        "A number minus five equals twenty.",
        "A number decreased from twenty is five.",
        "Five less than twenty is a number.",
        "Twenty minus a number equals five"
      ],
      "answer": "Twenty minus a number equals five"
    },
    {
      "question": "What does the equation 3x = 12 translate to?",
      "options": [
        "Twelve is three times a number.",
        "A number divided by three equals twelve.",
        "Three times a number equals twelve",
        "The product of three and a number is twelve."
      ],
      "answer": "Three times a number equals twelve"
    },
    {
      "question": "Translate: Six times a number decreased by 4 is 20.",
      "options": ["6x - 4 = 20", "6 - 4x = 20", "20 - 6x = 4", "4x - 6 = 20"],
      "answer": "6x - 4 = 20"
    },
    {
      "question": "Translate: The sum of a number and 50 is 100.",
      "options": [
        "x + 50 = 100",
        "50 - x = 100",
        "x - 50 = 100",
        "100 + x = 50"
      ],
      "answer": "x + 50 = 100"
    },
    {
      "question": "Translate: The sum of a number and 22 is 50.",
      "options": ["x + 22 = 50", "22 - x = 50", "x - 22 = 50", "50 + x = 22"],
      "answer": "x + 22 = 50"
    },
    {
      "question": "What does the equation 4x - 8 = 16 translate to?",
      "options": [
        "Four times a number decreased by eight equals sixteen.",
        "The difference of four times a number and eight is sixteen.",
        "Eight less than four times a number is sixteen",
        "Sixteen minus eight is four times a number."
      ],
      "answer": "Eight less than four times a number is sixteen"
    },
    {
      "question": "Translate: Five less than a number is 15.",
      "options": ["x - 5 = 15", "x + 5 = 15", "15 - x = 5", "x - 15 = 5"],
      "answer": "x - 5 = 15"
    },
    {
      "question": "What does the equation x + 8 = 32 mean?",
      "options": [
        "Thirty-two minus eight is a number.",
        "A number plus eight equals thirty-two.",
        "The sum of eight and a number is thirty-two.",
        "Eight more than a number is thirty-two"
      ],
      "answer": "Eight more than a number equals thirty-two"
    },
    {
      "question": "Translate: Four times a number plus 9 equals 25.",
      "options": ["4x + 9 = 25", "4 + 9x = 25", "x + 4 = 25", "25 - 4x = 9"],
      "answer": "4x + 9 = 25"
    },
    {
      "question": "What does the equation x - 3 = 5 translate to?",
      "options": [
        "Three less than a number is five.",
        "A number minus three equals five",
        "The difference of a number and three is five.",
        "Five more than a number is three."
      ],
      "answer": "A number minus three equals five"
    },
    {
      "question": "What does the equation x / 4 = 7 mean?",
      "options": [
        "Four minus a number equals seven.",
        "Four times a number is seven.",
        "Seven is one-fourth of a number.",
        "A number divided by four equals seven"
      ],
      "answer": "A number divided by four equals seven"
    },
    {
      "question": "Translate: A number decreased by 12 is 6.",
      "options": ["x - 12 = 6", "12 - x = 6", "x + 12 = 6", "6 / x = 12"],
      "answer": "x - 12 = 6"
    },
    {
      "question": "What does the equation x + 10 = 20 mean?",
      "options": [
        "Twenty minus a number is ten.",
        "A number plus ten equals twenty.",
        "The sum of ten and a number is twenty.",
        "Ten more than a number equals twenty"
      ],
      "answer": "Ten more than a number equals twenty"
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
      score = prefs.getInt('algebraicequationposttestscore') ??
          0; // Load saved score
      correctAnswers =
          prefs.getStringList('algebraicequationposttestcorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('algebraicequationposttestsavedQuestions') ??
              []; // Load saved questions

      status = prefs.getString('algebraicequationposttestCompleted') ?? '';
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
        await prefs.setStringList('algebraicequationposttestcorrectAnswers',
            correctAnswers); // Save correct answers
        await prefs.setInt(
            'algebraicequationposttestscore', score); // Save score
      }
    } else {
      // Handle case where the answer changes from correct to incorrect
      if (correctAnswers
          .contains(questions[currentQuestionIndex]['question'])) {
        correctAnswers.remove(questions[currentQuestionIndex]
            ['question']); // Remove from correct answers
        score--; // Decrease score
        await prefs.setStringList('algebraicequationposttestcorrectAnswers',
            correctAnswers); // Save updated correct answers
        await prefs.setInt(
            'algebraicequationposttestscore', score); // Save updated score
      }
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('algebraicequationposttestsavedQuestions',
        savedQuestions); // Save to local storage

    // Check if it's the last question
    if (currentQuestionIndex == questions.length - 1) {
      // If it's the last question, print the final score
      print("Score: $score");

      // Mark the test as completed if the score is 15 or above
      if (score >= 15) {
        await prefs.setString(
            'algebraicequationposttestCompleted', 'completed');
      }

      // Navigate to the results page or handle end of quiz here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Algebraicequationposttestview(),
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
        'algebraicequationposttestsavedQuestions'); // Clear savedQuestions from local storage
    setState(() {
      savedQuestions.clear();
    });
  }

  Future<void> _resetQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear the saved data in SharedPreferences
    await prefs.remove('algebraicequationposttestscore');
    await prefs.remove('algebraicequationposttestcorrectAnswers');
    await prefs.remove('algebraicequationposttestsavedQuestions');
    await prefs.remove('algebraicequationposttestCompleted');

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
          decoration: BoxDecoration(
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
                                          'Confirm to exit? ',
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
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WelcomePage()));
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
                                          Algebraicequationposttestview()),
                                ); // Navigate to the quiz start
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
