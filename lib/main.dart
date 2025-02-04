import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.bounceInOut,
      title: 'Calculator: Anthony Pellicone',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String displayText = ''; // This holds the expression for display.
  String result = ''; // This holds the result of the expression.

  // Function to handle button press events
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        displayText = ''; // Clear the expression
        result = ''; // Clear the result
      } else if (buttonText == '=') {
        try {
          String expressionToEvaluate;
          if (displayText.contains('=')) {
              // Extract everything after the first '=', allows it to function as using the ans button on a calculator
              expressionToEvaluate = displayText.substring(displayText.lastIndexOf('=') + 1).trim();          } else {
              expressionToEvaluate = displayText; // Otherwise parse the expression as the displaytext because there is no other result or computation
          }

          final expression = Expression.parse(expressionToEvaluate);
          final evaluator = ExpressionEvaluator();
          final evalResult = evaluator.eval(expression, {}); // Evaluate expression
          result = evalResult.toString();
          displayText += '=' + result; // Append result to displayText
      } catch (e) {
        result = "Error"; // Handle invalid expressions
      }
    } else {
        displayText += buttonText;
      }
    });
  }

  // Function to create a calculator button
  Widget calculatorButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.purpleAccent,
          ),
          onPressed: () => onButtonPressed(
              buttonText), // When it is pressed, append the text inside the button to the string that needs to be evaluated
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Calculator: Anthony Pellicone'),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent),
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Evenly space output so that it covers a majority of the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              // Display current expression
              displayText,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
              textAlign: TextAlign.right,
            ),
            Text(
              // Display result
              result,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            SizedBox(
                height:
                    30), // Display button lower on the screen (fill empty space with box so that it is not right below result)
            Column(
              // Display vertically
              children: [
                Row(
                  //Display horizontally
                  children: [
                    calculatorButton('7'),
                    calculatorButton('8'),
                    calculatorButton('9'),
                    calculatorButton('/'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('4'),
                    calculatorButton('5'),
                    calculatorButton('6'),
                    calculatorButton('*'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('1'),
                    calculatorButton('2'),
                    calculatorButton('3'),
                    calculatorButton('-'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('0'),
                    calculatorButton('.'),
                    calculatorButton('C'),
                    calculatorButton('+'),
                  ],
                ),
                Row(
                  children: [
                    calculatorButton('%'),
                    calculatorButton('='),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
