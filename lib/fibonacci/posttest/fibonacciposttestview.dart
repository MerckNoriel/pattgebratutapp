import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:pattgebratutapp/writingrulesforsequence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FibonacciposttestviewPage extends StatefulWidget {
  const FibonacciposttestviewPage({super.key});

  @override
  _FibonacciposttestviewPage createState() => _FibonacciposttestviewPage();
}

class _FibonacciposttestviewPage extends State<FibonacciposttestviewPage> {
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
      "question": //1
          "How many rows does Pascal's Triangle have to contain to find the 8th Fibonacci number through diagonals?",
      "options": ["5", "7", "8", "9"],
      "answer": "8"
    },
    {
      "question": //2
          "What is the sum of the numbers in the first row of Pascal's Triangle?",
      "options": ["1", "2", "3", "4"],
      "answer": "1"
    },
    {
      "question": //3
          "In Pascal's Triangle, what number is located at row 4, position 2?",
      "options": ["1", "4", "6", "3"],
      "answer": "3"
    },
    {
      "question": //4
          "What are the first two numbers of the Fibonacci Sequence?",
      "options": ["1,1", "0,1", "1,2", "2,3"],
      "answer": "0,1"
    },
    {
      "question": //5
          "Which of the following is NOT a Fibonacci number?",
      "options": ["0", "4", "3", "21"],
      "answer": "4"
    },
    {
      "question": //6
          "What is the pattern for generating Fibonacci numbers?",
      "options": [
        "Subtract the previous two numbers",
        "Multiply the previous two numbers",
        "Add the previous two numbers",
        "Divide the previous two numbers  "
      ],
      "answer": "Add the previous two numbers"
    },
    {
      "question": //7
          "What is Pascal's Triangle?",
      "options": [
        "A square arrangement of numbers",
        "A triangular arrangement of numbers",
        "A circular arrangement of numbers",
        "A linear arrangement of numbers"
      ],
      "answer": "A triangular arrangement of numbers"
    },
    {
      "question": //8
          "How do you find the Fibonacci numbers using Pascal's Triangle?",
      "options": [
        "By summing the rows",
        "By averaging the numbers",
        "By summing the diagonals",
        "By subtracting the numbers"
      ],
      "answer": "By summing the diagonals"
    },
    {
      "question": //9
          "Which of the following describes the relationship between Pascal's Triangle and the Fibonacci Sequence?",
      "options": [
        "Both are generated using the same mathematical operation.",
        "Fibonacci numbers appear as sums of the diagonals in Pascal's Triangle.",
        "They are unrelated.",
        "Both consist of only odd numbers."
      ],
      "answer":
          "Fibonacci numbers appear as sums of the diagonals in Pascal's Triangle."
    },
    {
      "question": //10
          "What is the first number in the Fibonacci Sequence?",
      "options": ["1", "3", "2", "0"],
      "answer": "0"
    },
    {
      "question": //11
          "How is each number in Pascal's Triangle created?",
      "options": [
        "By adding the two numbers above it",
        "By multiplying the two numbers above it",
        "By subtracting the two numbers above it",
        "By averaging the two numbers above it"
      ],
      "answer": "By adding the two numbers above it"
    },
    {
      "question": //12
          "What is the third Fibonacci number?",
      "options": ["1", "2", "3", "5"],
      "answer": "2"
    },
    {
      "question": //13
          "Which operation can be performed with two Fibonacci numbers?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Division"
    },
    {
      "question": //14
          "What is the sum of the first two Fibonacci numbers?",
      "options": ["3", "2", "1", "0"],
      "answer": "1"
    },
    {
      "question": //15
          "What is the fifth Fibonacci number?",
      "options": ["3", "13", "8", "5"],
      "answer": "5"
    },
    {
      "question": //16
          "How is the number 21 obtained in the Fibonacci Sequence?",
      "options": ["13 + 8", "8 + 5", "5 + 3", "34 - 13"],
      "answer": "13 + 8"
    },
    {
      "question": //17
          "What is 13 - 8?",
      "options": ["5", "3", "8", "1"],
      "answer": "5"
    },
    {
      "question": //18
          "If you multiply 5 by 3, what is the result?",
      "options": ["15", "8", "18", "13"],
      "answer": "15"
    },
    {
      "question": //19
          "What is the fourth Fibonacci number?",
      "options": ["2", "3", "5", "8"],
      "answer": "3"
    },
    {
      "question": //20
          "What is 21 ÷ 3",
      "options": ["5", "10", "7", "6"],
      "answer": "7"
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
      score = prefs.getInt('fibonacciposttestscore') ?? 0; // Load saved score
      correctAnswers =
          prefs.getStringList('fibonacciposttestcorrectAnswers') ?? [];
      savedQuestions =
          prefs.getStringList('fibonacciposttestsavedQuestions') ?? [];
      status = prefs.getString('fibonacciposttestCompleted') ?? '';
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
        await prefs.setStringList('fibonacciposttestcorrectAnswers',
            correctAnswers); // Save correct answers
        await prefs.setInt('fibonacciposttestscore', score); // Save score
      }
    } else {
      // Handle case where the answer changes from correct to incorrect
      if (correctAnswers
          .contains(questions[currentQuestionIndex]['question'])) {
        correctAnswers.remove(questions[currentQuestionIndex]
            ['question']); // Remove from correct answers
        score--; // Decrease score
        await prefs.setStringList('fibonacciposttestcorrectAnswers',
            correctAnswers); // Save updated correct answers
        await prefs.setInt(
            'fibonacciposttestscore', score); // Save updated score
      }
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('fibonacciposttestsavedQuestions',
        savedQuestions); // Save to local storage

    // Check if it's the last question
    if (currentQuestionIndex == questions.length - 1) {
      // If it's the last question, print the final score
      print(" Score: $score");

      // Check if the quiz is already marked as completed
      bool isAlreadyCompleted =
          prefs.getString('fibonacciposttestCompleted') == 'completed';

      // Mark as completed only if the score is 15 or above, or it is already completed
      if (score >= 15 || isAlreadyCompleted) {
        await prefs.setString('fibonacciposttestCompleted', 'completed');
      }

      // Navigate to the results page or handle end of quiz here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FibonacciposttestviewPage(),
        ),
      );
    } else {
      // If not the last question, wait for the user to press next manually
      print("Score: $score"); // Print the current score
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('fibonacciposttestscore');
    await prefs.remove(
        'fibonacciposttestsavedQuestions'); // Clear savedQuestions from local storage
    await prefs.remove('fibonacciposttestcorrectAnswers');
    setState(() {
      score = 0;
      savedQuestions.clear();
      correctAnswers.clear();
    });
  }

  Future<void> _resetQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear saved data except for the "completed" status
    await prefs.remove('fibonacciposttestscore');
    await prefs.remove('fibonacciposttestcorrectAnswers');
    await prefs.remove('fibonacciposttestsavedQuestions');

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
              colors: [Color(0xFF2F6609), Color(0xFFC1FFB1), Color(0xFF2F6609)],
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
                                              ),
                                            ),
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
                    score > 15
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
                                  // Displays the current question number and text if there are questions
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
                    // Displays the current question number and total questions if questions exist
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
                                  // Update the selected answer when an option is tapped
                                  _selectedAnswer =
                                      questions[currentQuestionIndex]['options']
                                          [index];
                                  _selectedAnswers[currentQuestionIndex] =
                                      _selectedAnswer!; // Save the selected answer
                                });
                                // Call the function to save the selected answer and update score
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
                                            FibonacciposttestviewPage()), // Navigate to the quiz start
                                  );
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
                                  if (status == 'pending') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WelcomePage()),
                                    );
                                  } else if (status == 'completed') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const WrtingRulesForSequencePage()),
                                    );
                                  }
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
                        ),
                      ),
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
