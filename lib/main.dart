import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculator createState() => _SimpleCalculator();
}

class _SimpleCalculator extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFont = 38.0;
  double resultFont = 48.0;

  onPressed(String text) {
    setState(() {
      if (text == "c") {
        equation = "0";
        result = "0";
        equationFont = 38.0;
        resultFont = 48.0;
      } else if (text == "x") {
        equationFont = 48.0;
        resultFont = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "0") {
          equation = "0";
        }
      } else if (text == "=") {
        equationFont = 38.0;
        resultFont = 48.0;
        expression = equation;
        expression = expression.replaceAll('⨰', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error"; 
        }
      } else {
        equationFont = 48.0;
        resultFont = 38.0;
        if (equation == "0") {
          equation = text;
        } else {
          equation = equation + text;
        }
      }
    });
  }

  @override
  Widget customButton(String text, double height, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * height,
      padding: const EdgeInsets.all(8.0),
      color: color,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            ),
          ),
        ),
        onPressed: () => onPressed(text),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFont),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFont),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        customButton("c", 1, Colors.redAccent),
                        customButton("x", 1, Colors.blueAccent),
                        customButton("÷", 1, Colors.blueAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        customButton("7", 1, Colors.black45),
                        customButton("8", 1, Colors.black45),
                        customButton("9", 1, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        customButton("4", 1, Colors.black45),
                        customButton("5", 1, Colors.black45),
                        customButton("6", 1, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        customButton("1", 1, Colors.black45),
                        customButton("2", 1, Colors.black45),
                        customButton("3", 1, Colors.black45),
                      ],
                    ),
                    TableRow(
                      children: [
                        customButton(".", 1, Colors.black45),
                        customButton("0", 1, Colors.black45),
                        customButton("00", 1, Colors.black45),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      customButton("⨰", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      customButton("-", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      customButton("+", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      customButton("=", 2, Colors.blueAccent),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
