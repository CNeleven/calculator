import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      showSemanticsDebugger: false,
      title: ("flutterKing"),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String test = '0';
  String result = '0';
  String expressions = '';
  double testFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        testFontSize = 38.0;
        resultFontSize = 48.0;
        test = '0';
        result = '0';
      } else if (buttonText == "DEl") {
        testFontSize = 48.0;
        resultFontSize = 38.0;

        test = test.substring(0, test.length - 1);
        if (test.isEmpty) {
          test = '0';
        }
      } else if (buttonText == "=") {
        testFontSize = 48.0;
        resultFontSize = 38.0;

        expressions = test;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expressions);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "what the Faz ?!";
        }
      } else {
        testFontSize = 38.0;
        resultFontSize = 48.0;
        if (test == "0") {
          test = buttonText;
        } else {
          test = test + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('calculator'),
      ),
      body: Column(children: [
        /// test
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            test,
            style: TextStyle(fontSize: testFontSize),
          ),
        ),

        /// result
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.black,
              height: 2,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Table(children: [
                TableRow(
                  children: [
                    buildButton('C', 1, Colors.red),
                    buildButton('C', 1, Colors.blue),
                    buildButton('C', 1, Colors.blue),
                  ],
                ),
                TableRow(
                  children: [
                    buildButton('7', 1, Colors.orange),
                    buildButton('8', 1, Colors.orange),
                    buildButton('9', 1, Colors.orange),
                  ],
                ),
                TableRow(
                  children: [
                    buildButton('4', 1, Colors.orange),
                    buildButton('5', 1, Colors.orange),
                    buildButton('6', 1, Colors.orange),
                  ],
                ),
                TableRow(
                  children: [
                    buildButton('3', 1, Colors.orange),
                    buildButton('2', 1, Colors.orange),
                    buildButton('1', 1, Colors.orange),
                  ],
                ),
                TableRow(
                  children: [
                    buildButton('0', 1, Colors.orange),
                    buildButton('00', 1, Colors.orange),
                    buildButton('.  ', 1, Colors.orange),
                  ],
                )
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: (Table(
                children: [
                  TableRow(children: [buildButton('DEl', 1, Colors.red)]),
                  TableRow(children: [buildButton('-', 1, Colors.red)]),
                  TableRow(children: [buildButton('+', 1, Colors.red)]),
                  TableRow(children: [buildButton('=', 2, Colors.red)]),
                ],
              )),
            )
          ],
        )
      ]),
    );
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(115.0),
          border: Border.all(color: Colors.black, width: 3.0)),
      child: TextButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        )),
      ),
    );
  }
}
