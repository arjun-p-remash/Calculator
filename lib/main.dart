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
    '0' , '.' , '' , '=' ,
  ];

  bool isOperator(String x){
    if(x=='/' || x=='*' || x=='-' || x=='+' || x=='%' || x=='='){
      return true;
    }
    else {
      return false;
    }
  }

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
      backgroundColor: Colors.grey[500],
      body: Column(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(

                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      expression,style: const TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.white70,
                          ),
                        ],
                      //color: Colors.white,
                        fontSize: 55,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text(answer,
                    style: const TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                          color: Colors.white70,
                        ),
                      ],
                      //color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,

                    ),),
                  )
                ],
              )
          ),
          Expanded(
            flex: 2,
              child: Container(

                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){
                      if(index==0){
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              expression='';
                              answer='';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                        );
                      }
                      else if(index ==1){
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
                        return Button(
                          buttonTapped: (){
                            setState(() {
                              evaluate();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColor: Colors.white,
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
                          color: isOperator(buttons[index])? Colors.blueGrey[800] : Colors.white,
                          textColor: isOperator(buttons[index])? Colors.white : Colors.blueGrey[800],
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
