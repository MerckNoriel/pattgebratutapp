import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pattgebratutapp/fibonaccisequence.dart';
import 'package:pattgebratutapp/thenthtermofasequence.dart';
import 'package:pattgebratutapp/top.dart';
import 'package:pattgebratutapp/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WrtingRulesForSequencePage extends StatefulWidget {
  const WrtingRulesForSequencePage({super.key});

  @override
  _WrtingRulesForSequencePage createState() => _WrtingRulesForSequencePage();
}

class _WrtingRulesForSequencePage extends State<WrtingRulesForSequencePage> {
  String statuspretest1 = 'pending';
  String statuspretest2 = 'pending';
  String status = 'pending';
  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data on initialization
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      statuspretest1 = prefs.getString('fibonaccipretestCompleted') ?? '';
      statuspretest2 =
          prefs.getString('thenthtermofasequencepretestCompleted') ?? '';
      status = prefs.getString('fibonacciposttestCompleted') ??
          ''; // Load saved score

      print("pretest: ${statuspretest1}");
      print("pretest: ${statuspretest2}");
      print(status);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: 30, left: 20),
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                  },
                ),
              ),
              TopPage(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
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
                              'Writing Rules For Sequence:',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
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
                      GestureDetector(
                        onTap: () {
                          if (statuspretest1 == 'completed') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FibonacciSequencePage()));
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (statuspretest1 == 'completed') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FibonacciSequencePage()));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2F6609),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Fibonacci Sequence \n",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '1 Lecture',
                                        style: TextStyle(
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
                                    if (statuspretest1 == 'pending') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FibonacciSequencePage()));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      status == 'completed'
                          ? GestureDetector(
                              onTap: () {
                                if (statuspretest2 != 'pending') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ThenthtermofasequencePage()));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2F6609),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "The Nth Term of a Sequence\n",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '1 Lecture',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      child: FaIcon(
                                        FontAwesomeIcons.circleArrowRight,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        if (statuspretest2 != 'completed') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ThenthtermofasequencePage()));
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(197, 61, 116, 25),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "The Nth Term of a Sequence\n",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '1 Lecture',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowRight,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: FaIcon(
                                      FontAwesomeIcons.lock,
                                      size: 28,
                                      color: const Color.fromARGB(
                                          210, 216, 216, 216),
                                    ),
                                  )
                                ],
                              ))
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
}

void main() => runApp(MaterialApp(home: WrtingRulesForSequencePage()));
