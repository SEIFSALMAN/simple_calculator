import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import '../styles/colors.dart';

class LandscapeCalculatorScreen extends StatefulWidget {
  const LandscapeCalculatorScreen({super.key});

  @override
  State<LandscapeCalculatorScreen> createState() => _LandscapeCalculatorScreenState();
}

class _LandscapeCalculatorScreenState extends State<LandscapeCalculatorScreen> {
  String userInput = "";
  String result = "0";
  List<String> calculationHistory = [];
  List<String> buttonList = [
    "AC","Rad","√","C", "(",")","/",
    "sin","cos","tan","7","8","8","*",
    "ln","log","∛","4","5","6","-",
    "ƒ","x²","xy","1","2","3","+",
    "|x|","∏","e","+/-","0",".","="
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: resultWidget(),
            ),
            Expanded(child: buttonWidget())
          ],
        ),
      ),
    );
  }

  Widget resultWidget()
  {
    return Stack(
      alignment: Alignment.bottomLeft,

      children: [
        Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              alignment: Alignment.centerRight,
              child: Text(result,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              alignment: Alignment.centerRight,
              child: Text(userInput,style: const TextStyle(fontSize: 20,color: Colors.grey),maxLines: 1),
            ),
          ],
        ),
      ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(onPressed: (){
            showHistoryDialog(context);
          }, icon: const Icon(Icons.history,size: 30,)),
        )
    ]
    );
  }

  Widget buttonWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 2.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
          itemBuilder: (context,index){
            return button(buttonList[index]);
          }),
    );
  }

  handleButton(String text){


    // if (text == "+/-") {
    //   if (result == "0") {
    //     return;
    //   } else if (result == "Error!") {
    //     return;
    //   } else {
    //     if (result != "0" && result[0] == "-") {
    //       setState(() {
    //         result.replaceFirst(RegExp("-"), "+");
    //         return;
    //       });
    //     } else if (result != "0" && result[0] != "-") {
    //       setState(() {
    //         result.substring(0, 0) + "-";
    //         return;
    //       });
    //     }
    //   }
    // }

    if(text == "0" && userInput.isEmpty){
      return;
    }

    if(text == "AC"){
      userInput = "";
      result = "0";
      return ;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0,userInput.length-1);
        return;
      }
      else
      {
        return null;
      }
    }

    if(text == "="){
      if(userInput.isEmpty){
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter Value")));
      }

      result = calculate();
      calculationHistory.add("$userInput = $result");
      userInput = result;
      userInput = "";
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }
    if(result != "0" && userInput.isEmpty){
      if(text == "/" || text == "+" || text == "-" || text == "*"){
        userInput = result;
      }
    }
    userInput = userInput + text;
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
      return evaluation.toString();
    } catch(e)
    {
      return "Error!";
    }
  }

  Widget button(String text){
    return InkWell(
      onTap: (){
        HapticFeedback.mediumImpact();
        setState(() {
          handleButton(text);
        });
      },
      child: Container(
        width:20,
        height: 20,
        decoration: BoxDecoration(
            color: getBGColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1
              )
            ]
        ),
        child: Center(
          child: Text(
            text,style: TextStyle(
              color: getColor(text),
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
    );
  }

  getColor(String text){
    if(text == "/" || text == "*" || text == "-" || text == "+" || text == "C" || text == "(" || text == ")"){
      return Colors.white;
    }
    if(text == "=" || text == "AC"){
      return Colors.white;
    }
  }

  getBGColor(String text){
    if(text == "AC"|| text == "C"){
      return Colors.redAccent;
    }
    if(text == "=" ||text == "-" ||text == "+" ||text == "*" || text == "/" || text == "(" || text == ")"){
      return  Colors.blue[200];
    }
    if(text == "1" ||text == "2" ||text == "3" ||text == "4" || text == "5" || text == "6" || text == "7"|| text == "8" || text == "9"|| text == "0" || text == "."){
      return Theme.of(context).cardColor;
    }
    return Theme.of(context).shadowColor;
  }



  void showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: const Text("Calculation History", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: calculationHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(calculationHistory[index]),
                );
              },
            ),
          ),
          backgroundColor: Theme.of(context).dialogBackgroundColor, // Set background color
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
