import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    double buttonSize = MediaQuery.of(context).size.width * 0.2; // Adjust size based on screen width
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(

        onPressed: () {
          // Call the calculation function with the button text
          calculation(btntxt);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: btncolor,  // Changed from iconColor
        ),
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: buttonSize * 0.35,
            color: txtcolor,
          ),
        ) // Changed from iconColor
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double buttonSize = isPortrait ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.15;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator', style: TextStyle(color: Colors.white),), backgroundColor: Colors.black,),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
          // Calculator display
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.all(10.0),
                  child: Text(text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 100),
                  ),
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // here buttons function will be called
              calcbutton('AC', Colors.grey, Colors.black),
              calcbutton('+/-', Colors.grey, Colors.black),
              calcbutton('%', Colors.grey, Colors.black),
              calcbutton('/', Colors.amber[700]!, Colors.white)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton('7', Colors.grey[850]!, Colors.black),
              calcbutton('8', Colors.grey[850]!, Colors.black),
              calcbutton('9', Colors.grey[850]!, Colors.black),
              calcbutton('x', Colors.amber[700]!, Colors.white)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton('4', Colors.grey[850]!, Colors.black),
              calcbutton('5', Colors.grey[850]!, Colors.black),
              calcbutton('6', Colors.grey[850]!, Colors.black),
              calcbutton('-', Colors.amber[700]!, Colors.white)
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              calcbutton('1', Colors.grey[850]!, Colors.black),
              calcbutton('2', Colors.grey[850]!, Colors.black),
              calcbutton('3', Colors.grey[850]!, Colors.black),
              calcbutton('+', Colors.amber[700]!, Colors.white)
            ],
          ),
        SizedBox(height: 10,),
          // now last row is different as it has 0 button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(50, 20, 128, 20),
                    // Add other styling properties if needed
                    backgroundColor: Colors.grey[850],
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
                calcbutton('.', Colors.grey[850]!, Colors.black),
                calcbutton('=', Colors.amber[700]!, Colors.white)
              ],
            ),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
  
  
  // Write calculator logic here
  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-$result';
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    if (numTwo == 0) {
      return 'Error'; // Handle division by zero
    }
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

}

// class AnimatedButton extends StatefulWidget {
//   final String btntxt;
//   final Color btncolor;
//   final Color txtcolor;
//   final VoidCallback onPressed;
//
//   const AnimatedButton({
//     required this.btntxt,
//     required this.btncolor,
//     required this.txtcolor,
//     required this.onPressed,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _AnimatedButtonState createState() => _AnimatedButtonState();
// }
//
// class _AnimatedButtonState extends State<AnimatedButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 100),
//       lowerBound: 0.9,
//       upperBound: 1.0,
//     );
//     _controller.forward(); // Start with normal size
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => _controller.reverse(), // Shrink on press
//       onTapUp: (_) {
//         _controller.forward(); // Return to normal size
//         widget.onPressed(); // Trigger button action
//       },
//       onTapCancel: () => _controller.forward(), // Reset if tap is canceled
//       child: ScaleTransition(
//         scale: _controller,
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width * 0.2,
//           height: MediaQuery.of(context).size.width * 0.2,
//           child: ElevatedButton(
//             onPressed: null, // Disable default onPressed
//             style: ElevatedButton.styleFrom(
//               shape: CircleBorder(),
//               backgroundColor: widget.btncolor,
//             ),
//             child: Text(
//               widget.btntxt,
//               style: TextStyle(
//                 fontSize: 35,
//                 color: widget.txtcolor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
