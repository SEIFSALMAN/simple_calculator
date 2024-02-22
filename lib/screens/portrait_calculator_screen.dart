import 'package:cv_projects/components/switcher.dart';
import 'package:cv_projects/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import '../cubit/appMode/app_mode_cubit.dart';

class PortraitCalculatorScreen extends StatefulWidget {
  const PortraitCalculatorScreen({super.key});

  @override
  State<PortraitCalculatorScreen> createState() =>
      _PortraitCalculatorScreenState();
}

class _PortraitCalculatorScreenState extends State<PortraitCalculatorScreen> {
  String userInput = "";
  String result = "0";
  List<String> calculationHistory = [];
  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: DarkLightSwitcher(),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.8,
            child: resultWidget(),
          ),
          Expanded(child: buttonWidget())
        ],
      ),
    );
  }

  Widget resultWidget() {
    return Stack(alignment: Alignment.bottomLeft, children: [
      Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              alignment: Alignment.centerRight,
              child: Text(result,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
              alignment: Alignment.centerRight,
              child: Text(userInput,
                  style: TextStyle(fontSize: 32, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: IconButton(
            onPressed: () {
              showHistoryDialog(context);
            },
            icon: const Icon(
              Icons.history,
              size: 30,
            )),
      )
    ]);
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return button(buttonList[index]);
          }),
    );
  }

  handleButton(String text) {



    if (text == "0" && userInput.isEmpty) {
      return;
    }

    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      if (userInput.isEmpty) {
        return ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please enter Value")));
      }

      result = calculate();
      calculationHistory.add("$userInput = $result");
      userInput = result;
      userInput = "";
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }
    if (result != "0" && userInput.isEmpty) {
      if (text == "/" || text == "+" || text == "-" || text == "*") {
        userInput = result;
      }
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error!";
    }
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        setState(() {
          handleButton(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: getBGColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return Colors.white;
    }
    if (text == "=" || text == "AC") {
      return Colors.white;
    }
  }

  getBGColor(String text) {
    if (text == "AC" || text == "C") {
      return Colors.redAccent;
    }
    if (text == "=" ||
        text == "-" ||
        text == "+" ||
        text == "*" ||
        text == "/" ||
        text == "(" ||
        text == ")") {
      return Colors.blue[200];
    }
    return Theme.of(context).cardColor;
  }

  void showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: const Text("Calculation History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: calculationHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(calculationHistory[index]),
                );
              },
            ),
          ),
          backgroundColor:
              Theme.of(context).dialogBackgroundColor, // Set background color
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: defaultLightColor, // Set the container color
                    borderRadius:
                        BorderRadius.circular(20), // Set border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Clear history
                      setState(() {
                        calculationHistory.clear();
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Set button text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Clear History"),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: defaultLightColor, // Set the container color
                    borderRadius:
                        BorderRadius.circular(20), // Set border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Set button text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Close"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
