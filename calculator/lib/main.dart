import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  CalculatorApp({Key key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String equation = "0";
  String result = "0";

  handleButtonPressed(String text) {
    setState(() {
      if (text == "C") {
        result = "0";
        equation = "0";
      } else if (text == "⌫") {
        if (equation != "0") {
          equation = equation.substring(0, equation.length - 1);
        }
        if (equation == "") equation = "0";
      } else if (text == "=") {
        try {
          var currentEquation = equation;
          currentEquation = currentEquation.replaceAll('×', '*');
          currentEquation = currentEquation.replaceAll('÷', '/');
          var parser = Parser();
          var expression = parser.parse(currentEquation);
          var ctx = ContextModel();
          result = "${expression.evaluate(EvaluationType.REAL, ctx)}";
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (equation == "0") equation = "";
        equation = equation + text;
      }
    });
  }

  Widget buildButton(String text, double height, Color color) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * height,
      color: color,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16),
        onPressed: () => handleButtonPressed(text),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: (Text(
              equation,
              style: TextStyle(fontSize: 38.0),
            )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: (Text(
              result,
              style: TextStyle(fontSize: 48.0),
            )),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('C', 1, Colors.redAccent),
                      buildButton('⌫', 1, Colors.blue),
                      buildButton('÷', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('7', 1, Colors.black54),
                      buildButton('8', 1, Colors.black54),
                      buildButton('9', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('4', 1, Colors.black54),
                      buildButton('5', 1, Colors.black54),
                      buildButton('6', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('1', 1, Colors.black54),
                      buildButton('2', 1, Colors.black54),
                      buildButton('3', 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton('.', 1, Colors.black54),
                      buildButton('0', 1, Colors.black54),
                      buildButton('00', 1, Colors.black54),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('×', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('-', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('+', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton('=', 2, Colors.redAccent),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
