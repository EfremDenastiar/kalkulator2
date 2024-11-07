import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white
          )
        ),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';

  void buttonPressed (String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        output = '0';
      }
      else if (buttonText == '=') {
        try {
          output = evaluateExpression(output);
        }
        catch(e){
          output = 'error';
        }
      } 
      else {
        if (output == '0') {
          output = buttonText;
        }
        else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression){
    final parsedExpression = Expression.parse(expression);
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
  }

  buildbutton (String buttonText, Color color, {double widthFactor = 1.0 }) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: ()=>buttonPressed(buttonText), 
          child: Text(buttonText,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
            )
          ),
        ),
        
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: 24,
                bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(output,
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          Column(
            children: [
              Row(
                children: [
                  buildbutton('C', Colors.grey.shade600),
                  buildbutton('+/-', Colors.grey.shade600),
                  buildbutton('%', Colors.grey.shade600),
                  buildbutton('/', Colors.orange)
                ],
              ),
              Row(
                children: [
                  buildbutton('7', Colors.grey.shade800),
                  buildbutton('8', Colors.grey.shade800),
                  buildbutton('9', Colors.grey.shade800),
                  buildbutton('*', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildbutton('4', Colors.grey.shade800),
                  buildbutton('5', Colors.grey.shade800),
                  buildbutton('6', Colors.grey.shade800),
                  buildbutton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildbutton('1', Colors.grey.shade800),
                  buildbutton('2', Colors.grey.shade800),
                  buildbutton('3', Colors.grey.shade800),
                  buildbutton('+', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildbutton('0', widthFactor: 2.0, Colors.grey.shade800),
                  buildbutton('.', Colors.grey.shade800),
                  buildbutton('=', Colors.orange),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
