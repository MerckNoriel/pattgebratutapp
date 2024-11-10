import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/algebraicequation/posttest/algebraicequationposttestview.dart';
import 'package:pattgebratutapp/algebraicexpression/posttest/algebraicexpressionposttestview.dart';
import 'package:pattgebratutapp/fibonacci/posttest/fibonacciposttestview.dart';
import 'package:pattgebratutapp/sidebar.dart';
import 'package:pattgebratutapp/solvingequation/posttest/solvingequationposttestview.dart';
import 'package:pattgebratutapp/thenthtermofasequence/posttest/thenthtermofasequenceposttest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  _PerformancePage createState() => _PerformancePage();
}

class _PerformancePage extends State<PerformancePage> {
  String status = 'pending';
  String status2 = 'pending';
  String status3 = 'pending';
  String status4 = 'pending';

  String statuspretest1 = 'pending';
  String statuspretest2 = 'pending';
  String preteststatus3 = 'pending';
  String preteststatus4 = 'pending';
  String preteststatus5 = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      statuspretest1 = prefs.getString('fibonaccipretestCompleted') ?? '';
      statuspretest2 =
          prefs.getString('thenthtermofasequencepretestCompleted') ?? '';
      preteststatus3 =
          prefs.getString('algebraicexpressionpretestCompleted') ?? '';
      preteststatus4 =
          prefs.getString('algebraicequationpretestCompleted') ?? '';
      preteststatus5 = prefs.getString('solvingequationpretestCompleted') ?? '';

      status = prefs.getString('fibonacciposttestCompleted') ?? '';
      status2 = prefs.getString('thenthtermofasequenceposttestCompleted') ?? '';
      status3 = prefs.getString('algebraicexpressionposttestCompleted') ?? '';
      status4 = prefs.getString('algebraicequationposttestCompleted') ?? '';

      print(status4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarPage(),
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.bottomLeft,
                child: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Open the drawer
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Patterns and Algebra \n',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'Test Performance',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Let's take a test together \n",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 50,
                            decoration: BoxDecoration(
                                color: Color(0xDDaafa42),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Image(
                              image: AssetImage('assets/brain.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          'Pattgebra',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Test:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            Center(
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Image(
                                  image: AssetImage('assets/quiz.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 2,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                      ),
                      const SizedBox(height: 15),
                      widgetCard('1', 'Fibonacci Suquence Test'),
                      status == 'completed'
                          ? widgetCard('2', 'The Nth of a Sequence Test')
                          : widgetCard2('2', 'The Nth of a Sequence Test'),
                      status2 == 'completed'
                          ? widgetCard('3', 'Algebraic Expression')
                          : widgetCard2('3', 'Algebraic Expression'),
                      status3 == 'completed'
                          ? widgetCard('4', 'Algebraic Equation')
                          : widgetCard2('4', 'Algebraic Equation'),
                      status4 == 'completed'
                          ? widgetCard('5', 'Solving Equation')
                          : widgetCard2('5', 'Solving Equation'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  widgetCard(String id, String label1) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F6609),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: label1,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: const FaIcon(
                  FontAwesomeIcons.circleArrowRight,
                  color: Colors.white,
                ),
                onTap: () {
                  if (id == '1') {
                    if (statuspretest1 != 'pending') {
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
                                    'Confirm to take post test?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FibonacciposttestviewPage()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF2F6609),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                              horizontal: 40, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F6609),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.white),
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
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FibonacciposttestviewPage()));
                    }
                  }
                  if (id == '2') {
                    if (statuspretest2 != 'pending') {
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
                                    'Confirm to take post test?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ThenthtermofasequenceposttestviewPage()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF2F6609),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                                                horizontal: 40, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Color(0xFF2F6609),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ThenthtermofasequenceposttestviewPage()));
                    }
                  } else if (id == '3') {
                    if (preteststatus3 != 'pending') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(221, 48, 102, 9),
                                    Color.fromARGB(238, 48, 102, 9)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Confirm to take post test?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Algebraicexpressionposttestview()));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF2F6609),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF2F6609),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.white),
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
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Algebraicexpressionposttestview()));
                    }
                  } else if (id == '4') {
                    if (preteststatus4 != 'pending') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(221, 48, 102, 9),
                                    Color.fromARGB(238, 48, 102, 9)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Confirm to take post test?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Algebraicequationposttestview()));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF2F6609),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF2F6609),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.white),
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
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Algebraicequationposttestview()));
                    }
                  } else if (id == '5') {
                    if (preteststatus5 != 'pending') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(221, 48, 102, 9),
                                    Color.fromARGB(238, 48, 102, 9)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Confirm to take post test?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Solvingequationposttestview()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF2F6609),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF2F6609),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Text(
                                            'NO',
                                            style:
                                                TextStyle(color: Colors.white),
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
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Solvingequationposttestview()));
                    }
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  widgetCard2(String id, String label1) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(197, 61, 116, 25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: label1,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              FaIcon(
                FontAwesomeIcons.circleArrowRight,
                color: Colors.white,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.lock,
              size: 28,
              color: const Color.fromARGB(210, 216, 216, 216),
            ),
          )
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PerformancePage()));
