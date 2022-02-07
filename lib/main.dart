import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var expression = '';
  var answer = '';

  final List<String> buttons=[
    'AC' , 'DEL' , '%' , '/' ,
    '7' , '8' , '9' , '*' ,
    '4' , '5' , '3' , '-' ,
    '1' , '2' , '3' , '+' ,
    '0' , '.' , 'ANS' , '=' ,
  ];

  //to check whether it is an operator or not
  bool isOperator(String x){
    if(x=='/' || x=='*' || x=='-' || x=='+' || x=='%' || x=='='){
      return true;
    }
    else {
      return false;
    }
  }

  //to find the solution of user expression
  void evaluate(){
    String str = expression;
    Parser p = Parser();
    Expression exp = p.parse(str);
    // Bind variables:
    ContextModel cm = ContextModel();
    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    //user input expression
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        expression,style: const TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(3.0, 2.0),
                              blurRadius: 10.0,
                              color: Colors.black,
                            ),
                          ],
                        color: Colors.white,
                          fontSize: 55,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                      ),
                    ),
                  ),

                  Container(
                    //Solution of expression
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(answer,
                      style: const TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(3.0, 2.0),
                            blurRadius: 10.0,
                            color: Colors.black,
                          ),
                        ],
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,

                      ),),
                    ),
                  )
                ],
              )
          ),
          Expanded(
            flex: 2,
              child: Container(

                child: GridView.builder(
                  //grid view of buttons
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){

                      if(index==0){
                        //for AC button
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              expression='';
                              answer='';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.orangeAccent[700],
                          textColor: Colors.white,
                        );
                      }

                      else if(index ==1){
                        //for DEL button
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              expression=expression.substring(0,expression.length-1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red[900],
                          textColor: Colors.white,
                        );
                      }

                      else if(index==buttons.length-1){
                        //for = button
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              evaluate();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green[900],
                          textColor: Colors.white,
                        );
                      }

                      else if(index==buttons.length-2){
                        //for ANS button
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              expression+=answer;
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black54,
                          textColor: Colors.blueGrey[300],
                        );
                      }

                      else{
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              expression += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])? Colors.black : Colors.black54,
                          textColor: isOperator(buttons[index])? Colors.white : Colors.blueGrey[300],
                        );
                      }
                    }),
              )
          )
        ],
      ),
    );
  }
}
