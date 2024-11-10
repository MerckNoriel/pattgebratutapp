import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Solvingequationposttestview extends StatefulWidget {
  const Solvingequationposttestview({super.key});

  @override
  _Solvingequationposttestview createState() => _Solvingequationposttestview();
}

class _Solvingequationposttestview extends State<Solvingequationposttestview> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  String status = 'pending';
  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What does the phrase 'three times a number' represent?",
      "options": ["3 + x", "x + 3", "3x", "x / 3"],
      "answer": "3x"
    },
    {
      "question": "What is the solution to the equation 4x - 8 = 0?",
      "options": ["2", "8", "0", "-2"],
      "answer": "2"
    },
    {
      "question":
          "If the equation is 3x - 2 = 7, what is the first operation you should perform to isolate x?",
      "options": [
        "Add 2 to both sides",
        "Subtract 3 from both sides",
        "Multiply both sides by 3",
        "Divide both sides by 3"
      ],
      "answer": "Add 2 to both sides"
    },
    {
      "question": "What does 'twice a number' mean mathematically?",
      "options": ["x + 2", "2 + x", "x2", "2x"],
      "answer": "2x"
    },
    {
      "question":
          "Which equation represents the phrase 'The quotient of a number and 4 is 10'?",
      "options": ["x + 4 = 10", "x - 4 = 10", "x / 4 = 10", "4x = 10"],
      "answer": "x / 4 = 10"
    },
    {
      "question":
          "Which of the following represents the phrase '5 less than a number'?",
      "options": ["x + 5", "x - 5", "5x", "5/x"],
      "answer": "x - 5"
    },
    {
      "question": "To solve 5x = 25, what should you do first?",
      "options": ["Add 5", "Subtract 5", "Divide by 5", "Multiply by 5"],
      "answer": "Divide by 5"
    },
    {
      "question": "What is the variable in the equation 2x + 3 = 11?",
      "options": ["2", "3", "11", "x"],
      "answer": "x"
    },
    {
      "question": "What does the phrase 'sum of a number and 5' represent?",
      "options": ["x - 5", "x + 5", "5x", "5 - x"],
      "answer": "x + 5"
    },
    {
      "question": "What does the phrase 'is equal to' indicate in an equation?",
      "options": ["Addition", "Subtraction", "Equals", "Division"],
      "answer": "Equals"
    },
    {
      "question":
          "Which equation represents the phrase 'The difference of 10 and a number is 4'?",
      "options": ["10 + x = 4", "10 - x = 4", "x - 10 = 4", "10 = x - 4"],
      "answer": "10 - x = 4"
    },
    {
      "question": "Solve the equation 2x = 10. What is x?",
      "options": ["2", "5", "10", "20"],
      "answer": "5"
    },
    {
      "question": "If x + 9 = 15, what is the value of x?",
      "options": ["6", "5", "4", "3"],
      "answer": "6"
    },
    {
      "question": "What does 'product of a number and 7' mean?",
      "options": ["x + 7", "x - 7", "7x", "7 - x"],
      "answer": "7x"
    },
    {
      "question":
          "Which equation represents the phrase 'The sum of a number and 12 is 30'?",
      "options": ["x + 12 = 30", "x - 12 = 30", "x + 30 = 12", "12 - x = 30"],
      "answer": "x + 12 = 30"
    },
    {
      "question": "What is the first step to solve x + 8 = 20?",
      "options": [
        "Subtract 8 from both sides",
        "Add 8 to both sides",
        "Divide both sides by 8",
        "Multiply both sides by 8"
      ],
      "answer": "Subtract 8 from both sides"
    },
    {
      "question":
          "What is the last step to solve for x in the equation x + 4 = 12?",
      "options": [
        "Add 4 to both sides",
        "Subtract 4 from both sides",
        "Multiply both sides by 4",
        "Divide both sides by 4"
      ],
      "answer": "Subtract 4 from both sides"
    },
    {
      "question":
          "If you have the equation x + 4 = 12, what is the last step to solve for x?",
      "options": [
        "Add 4 to both sides",
        "Subtract 4 from both sides",
        "Multiply both sides by 4",
        "Divide both sides by 4"
      ],
      "answer": "Subtract 4 from both sides"
    },
    {
      "question": "If 3(x + 1) = 12, what is the value of x?",
      "options": ["2", "5", "4", "3"],
      "answer": "3"
    },
    {
      "question":
          "What equation represents the phrase 'The difference of 10 and a number is 4'?",
      "options": ["10 + x = 4", "10 - x = 4", "x - 10 = 4", "10 = x - 4"],
      "answer": "10 - x = 4"
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
      score =
          prefs.getInt('solvingequationposttestscore') ?? 0; // Load saved score
      correctAnswers =
          prefs.getStringList('solvingequationposttestcorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('solvingequationposttestsavedQuestions') ??
              []; // Load saved questions
      status = prefs.getString('solvingequationposttestCompleted') ?? '';
    });

    // Filter out questions that are already saved
    questions.removeWhere(
        (question) => savedQuestions.contains(question['question']));
  }

  Future<void> _saveSelectedAnswer(String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the selected answer is correct
    if (answer == questions[currentQuestionIndex]['answer']) {
      correctAnswers.add(answer); // Add correct answer to the list
      score++; // Increase score for the correct answer
      await prefs.setStringList('solvingequationposttestcorrectAnswers',
          correctAnswers); // Save to local storage
      await prefs.setInt(
          'solvingequationposttestscore', score); // Save score to local storage
      await prefs.setString('solvingequationposttestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('solvingequationposttestsavedQuestions',
        savedQuestions); // Save to local storage

    // Print score and move to the next question automatically
    print("Score: $score"); // Print the current score
    _nextQuestion();
  }

  void _nextQuestion() async {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        _selectedAnswer = null; // Reset selected answer for the next question
      });
    } else {
      // Show a dialog or message when all questions are completed
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (score >= 15) {
        await prefs.setString('solvingequationposttestCompleted', 'completed');
      } else {
        _clearSavedQuestions();
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Solvingequationposttestview()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'solvingequationposttestsavedQuestions'); // Clear savedQuestions from local storage
    await prefs.setString('solvingequationposttestCompleted', 'pending');
    await prefs.setInt('solvingequationposttestscore', 0);
    setState(() {
      savedQuestions.clear(); // Clear the savedQuestions list in the app
      // Optionally, you can also reset other related state variables if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2.1;

    // Check if there are available questions after filtering
    bool hasQuestions = questions.isNotEmpty;

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
                                        'Confirm to exit? Your Progress will be save.',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
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
              SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: _clearSavedQuestions,
              //   child: Text("Clear Saved Questions"),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //   ),
              // ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
