import 'package:flutter/material.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: '1',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '2',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '3',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: '4',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '5',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '6',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: '7',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '8',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '9',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to delete the last number
              NumberButton(
                number: '*',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // IconButton(
              //   onPressed: () => delete(),
              //   icon: Icon(
              //     Icons.backspace,
              //     color: iconColor,
              //   ),
              //   iconSize: buttonSize,
              // ),
              NumberButton(
                number: '0',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // this button is used to submit the entered value
              NumberButton(
                number: '#',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // IconButton(
              //   onPressed: () => onSubmit(),
              //   icon: Icon(
              //     Icons.done_rounded,
              //     color: iconColor,
              //   ),
              //   iconSize: buttonSize,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final String number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.text += number.toString();
      },
      child: SizedBox(
        width: size*2,
        height: size,
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30),
          ),
        ),
      ),
    );
  }
}
/*
 */

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('KindaCode.com'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // display the entered numbers
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextField(
                    controller: _myController,
                    textAlign: TextAlign.center,
                    //showCursor: false,
                    style: const TextStyle(fontSize: 40),
                    // Disable the default soft keyboard
                    keyboardType: TextInputType.none,
                  )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
            buttonSize: 75,
            buttonColor: Colors.purple,
            iconColor: Colors.deepOrange,
            controller: _myController,
            delete: () {
              _myController.text = _myController.text
                  .substring(0, _myController.text.length - 1);
            },
            // do something with the input numbers
            onSubmit: () {
              debugPrint('Your code: ${_myController.text}');
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(
                      "You code is ${_myController.text}",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}