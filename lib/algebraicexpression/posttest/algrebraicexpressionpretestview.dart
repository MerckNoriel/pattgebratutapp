import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/algebraicexpression.dart';
import 'package:pattgebratutapp/understandingalgebraicexpression1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Algebraicexpressionpretestview extends StatefulWidget {
  const Algebraicexpressionpretestview({super.key});

  @override
  _Algebraicexpressionpretestview createState() =>
      _Algebraicexpressionpretestview();
}

class _Algebraicexpressionpretestview
    extends State<Algebraicexpressionpretestview> {
  String? _selectedAnswer; // To store the selected answer
  int currentQuestionIndex = 0;
  List<String> correctAnswers = []; // To store correct answers
  int score = 0; // To keep track of the score
  List<String> savedQuestions = []; // To track saved questions

  String status = 'pending';

  // List of questions and answers
  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is an algebraic expression?",
      "options": [
        "A mathematical statement with an equal sign",
        "A combination of numbers, variables, and operation symbols",
        "A single fixed number",
        "A formula used in geometry"
      ],
      "answer": "A combination of numbers, variables, and operation symbols"
    },
    {
      "question": "Which of the following is a constant?",
      "options": ["x", "z", "y", "7.5"],
      "answer": "7.5"
    },
    {
      "question": "In the expression 5x + 3, what is the coefficient of x?",
      "options": ["5", "3", "x", "8"],
      "answer": "5"
    },
    {
      "question": "What does the operator '+' signify in an expression?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Addition"
    },
    {
      "question": "Which of the following is a monomial?",
      "options": ["3x + 2", "7y", "5x - 4y", "x + y + z"],
      "answer": "7y"
    },
    {
      "question": "What type of expression is 4x - 5?",
      "options": ["Monomial", "Polynomial", "Trinomial", "Binomial"],
      "answer": "Binomial"
    },
    {
      "question": "Identify the variable in the expression 3x + 2.",
      "options": ["3", "2", "x", "5"],
      "answer": "x"
    },
    {
      "question": "Which phrase translates to the expression 2y + 5?",
      "options": [
        "Five more than twice a number",
        "Twice a number minus five",
        "The product of 2 and y plus 5",
        "The sum of 2 and y"
      ],
      "answer": "Five more than twice a number"
    },
    {
      "question":
          "What is the expression for 'Three times a number decreased by 4'?",
      "options": ["3x - 4", "3x + 4", "x - 4", "4x - 3"],
      "answer": "3x - 4"
    },
    {
      "question": "In the expression 8 - 2a, what is the constant?",
      "options": ["8", "-2", "a", "2"],
      "answer": "8"
    },
    {
      "question": "What does the term 'difference of' indicate in a phrase?",
      "options": ["Addition", "Subtraction", "Multiplication", "Division"],
      "answer": "Subtraction"
    },
    {
      "question":
          "Which expression represents 'the product of 7 and a number'?",
      "options": ["7 + x", "7 - x", "7x", "x/7"],
      "answer": "7x"
    },
    {
      "question": "What type of expression is 2x^2 + 3x + 5?",
      "options": ["Monomial", "Binomial", "Trinomial", "Quadrinomial"],
      "answer": "Trinomial"
    },
    {
      "question":
          "Identify the expression that corresponds to 'A number divided by 4.'",
      "options": ["x + 4", "x - 4", "x/4", "4/x"],
      "answer": "x/4"
    },
    {
      "question": "What does the phrase 'more than' signify in an expression?",
      "options": ["Subtraction", "Addition", "Division", "Multiplication"],
      "answer": "Addition"
    },
    {
      "question": "Which expression matches 'Five less than a number'?",
      "options": ["5 + x", "x + 5", "5 - x", "x - 5"],
      "answer": "x - 5"
    },
    {
      "question": "What is the coefficient of y in the expression 4y - 2?",
      "options": ["4", "-2", "y", "2"],
      "answer": "4"
    },
    {
      "question":
          "Which of the following expressions represents 'the sum of a number and 15'?",
      "options": ["x - 15", "x + 15", "15 - x", "15 + x"],
      "answer": "x + 15"
    },
    {
      "question":
          "What does the phrase 'twice a number' represent in an expression?",
      "options": ["2 + x", "2x", "x + 2", "x/2"],
      "answer": "2x"
    },
    {
      "question": "Which expression represents 'a number increased by 9'?",
      "options": ["x - 9", "9 + x", "x + 9", "9 - x"],
      "answer": "x + 9"
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
      score = prefs.getInt('algebraicexpressionpretestscore') ?? 0;
      correctAnswers =
          prefs.getStringList('algebraicexpressioncorrectAnswers') ??
              []; // Load saved answers
      savedQuestions =
          prefs.getStringList('algebraicexpressionsavedQuestions') ??
              []; // Load saved questions

      status = prefs.getString('algebraicexpressionpretestCompleted') ?? '';
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
      await prefs.setStringList('algebraicexpressioncorrectAnswers',
          correctAnswers); // Save to local storage
      await prefs.setInt('algebraicexpressionpretestscore',
          score); // Save score to local storage
      await prefs.setString('algebraicexpressionpretestCompleted', 'pending');
    }

    // Save the current question to the savedQuestions list
    savedQuestions.add(questions[currentQuestionIndex]['question']);
    await prefs.setStringList('algebraicexpressionsavedQuestions',
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('algebraicexpressionpretestCompleted', 'completed');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Algebraicexpressionpretestview()));
    }
  }

  Future<void> _clearSavedQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'algebraicexpressionsavedQuestions'); // Clear savedQuestions from local storage

    // Clear the local list
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AlgebraicExpressionPage()));
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
                                      ? Colors.red
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
                                            Understandingalgebraicexpression1()));
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
                                    null; // Reset selected answer for the previous question
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
                                    null; // Reset selected answer for the next question
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
