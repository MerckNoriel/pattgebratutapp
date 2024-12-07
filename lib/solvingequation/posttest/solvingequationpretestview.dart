import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/solvingequation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Solvingequationpretestview extends StatefulWidget {
  const Solvingequationpretestview({super.key});

  @override
  _Solvingequationpretestview createState() => _Solvingequationpretestview();
}

class _Solvingequationpretestview extends State<Solvingequationpretestview> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions
  Map<int, String> _selectedAnswers =
      {}; // Map to store selected answers by question index

  String status = 'pending';

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What does the phrase 'sum of a number and 5' represent?",
      "options": ["x + 5", "x - 5", "5x", "5 - x"],
      "answer": "x + 5"
    },
    {
      "question": "Which operation does 'difference of' indicate?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Subtraction"
    },
    {
      "question":
          "What equation represents the phrase 'The quotient of a number and 4 is 10'?",
      "options": ["x + 4 = 10", "x - 4 = 10", "x / 4 = 10", "4x = 10"],
      "answer": "x / 4 = 10"
    },
    {
      "question": "What is the variable in the equation 2x + 3 = 11?",
      "options": ["2", "3", "11", "x"],
      "answer": "x"
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
          "Which equation represents the phrase 'The difference of 10 and a number is 4'?",
      "options": ["10 + x = 4", "10 - x = 4", "x - 10 = 4", "10 = x - 4"],
      "answer": "10 - x = 4"
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
      "question": "Solve the equation 2x = 10. What is x?",
      "options": ["2", "5", "10", "20"],
      "answer": "5"
    },
    {
      "question": "What does the phrase 'is equal to' indicate in an equation?",
      "options": ["Addition", "Subtraction", "Equals", "Division"],
      "answer": "Equals"
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
      "question": "Solve x - 5 = 10. What is x?",
      "options": ["15", "5", "10", "20"],
      "answer": "15"
    },
    {
      "question": "What does 'twice a number' mean mathematically?",
      "options": ["x + 2", "2 + x", "x2", "2x"],
      "answer": "2x"
    },
    {
      "question":
          "Which equation represents the phrase 'The sum of a number and 12 is 30'?",
      "options": ["x + 12 = 30", "x - 12 = 30", "x + 30 = 12", "12 - x = 30"],
      "answer": "x + 12 = 30"
    },
    {
      "question": "To solve 5x = 25, what should you do first?",
      "options": ["Add 5", "Subtract 5", "Divide by 5", "Multiply by 5"],
      "answer": "Divide by 5"
    },
    {
      "question": "If 3(x + 1) = 12, what is the value of x?",
      "options": ["2", "5", "4", "3"],
      "answer": "3"
    },
    {
      "question": "What is the solution to the equation 4x - 8 = 0?",
      "options": ["2", "8", "0", "-2"],
      "answer": "2"
    },
    {
      "question":
          "Which of the following represents the phrase '5 less than a number'?",
      "options": ["x + 5", "x - 5", "5x", "5/x"],
      "answer": "x - 5"
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
      "question": "What does the phrase 'three times a number' represent?",
      "options": ["3 + x", "x + 3", "3x", "x / 3"],
      "answer": "3x"
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
      score = prefs.getInt('solvingequationpretestscore') ?? 0;
      correctAnswers = prefs.getStringList('solvingequationcorrectAnswers') ??
          []; // Load saved answers
      savedQuestions = prefs.getStringList('solvingequationsavedQuestions') ??
          []; // Load saved questions
      status = prefs.getString('solvingequationpretestCompleted') ?? '';
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
        await prefs.setStringList('solvingequationcorrectAnswers',
            correctAnswers); // Save correct answers
        await prefs.setInt('solvingequationpretestscore', score); // Save score
      }
    } else {
      // Handle case where the answer changes from correct to incorrect
      if (correctAnswers
          .contains(questions[currentQuestionIndex]['question'])) {
        correctAnswers.remove(questions[currentQuestionIndex]
            ['question']); // Remove from correct answers
        score--; // Decrease score
        await prefs.setStringList('solvingequationcorrectAnswers',
            correctAnswers); // Save updated correct answers
        await prefs.setInt(
            'solvingequationpretestscore', score); // Save updated score
      }
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('solvingequationsavedQuestions',
        savedQuestions); // Save to local storage

    // Check if it's the last question
    if (currentQuestionIndex == questions.length - 1) {
      // If it's the last question, print the final score
      print("Score: $score");

      // Mark the test as completed if the score is 15 or above
      if (score >= 1) {
        await prefs.setString('solvingequationpretestCompleted', 'completed');
      }

      // Navigate to the results page or handle end of quiz here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Solvingequationpretestview(),
        ),
      );
    } else {
      // If not the last question, wait for the user to press next manually
      print("Score: $score"); // Print the current score
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('solvingequationpretestscore');
    await prefs.remove(
        'solvingequationsavedQuestions'); // Clear savedQuestions from local storage
    await prefs.remove('solvingequationcorrectAnswers');

    // Clear the local list
    setState(() {
      score = 0;
      savedQuestions.clear(); // Clear the savedQuestions list in the app
      correctAnswers.clear();

      // Optionally, you can also reset other related state variables if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width / 2.1;

    // Check if there are available questions after filtering
    bool hasQuestions = questions.isNotEmpty;
    bool isTestCompleted = currentQuestionIndex >= questions.length;

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
                  color: Color(0xFF2F6609),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    if (!isTestCompleted)
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 20),
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          child: FaIcon(FontAwesomeIcons.arrowLeft,
                              color: Colors.white),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SolvingEquationPage()));
                          },
                        ),
                      ),
                    SizedBox(height: 20),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SolvingEquationPage()));
                              },
                              child: const Text(
                                'Proceed',
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
              if (!isTestCompleted)
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
