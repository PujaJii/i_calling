import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DialPad extends StatefulWidget {
  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  String display = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const ListTile(
        leading: Icon(
          Icons.home,
          size: 40,
        ),
        trailing:  Icon(
          Icons.person_outline,
          size: 40,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  display,
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Container(
                width: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    const Align(
                      alignment: Alignment.bottomRight,
                      child:  Icon(
                        Icons.person_add,
                        size: 35,
                        color: Color(0x3300AF5B),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (display.isNotEmpty) {
                          setState(() {
                            display = display.substring(0, display.length - 1);
                          });
                        }
                      },
                      child: const Icon(
                        Icons.backspace,
                        size: 35,
                        color: Color(0x3300AF5B),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                dialPadButton(size, '1'),
                dialPadButton(size, '2'),
                dialPadButton(size, '3')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '4'),
                dialPadButton(size, '5'),
                dialPadButton(size, '6')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '7'),
                dialPadButton(size, '8'),
                dialPadButton(size, '9')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '*', color: const Color(0x3300AF5B),),
                dialPadButton(size, '0'),
                dialPadButton(size, '#', color: const Color(0x3300AF5B),)
              ],
            ),
            InkWell(
              child: Container(
                height: 80,
                width: double.infinity,
                color: const Color(0x3300AF5B),
                child: const Center(
                  child:  Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              onTap: () async{
                FlutterPhoneDirectCaller.callNumber(display);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dialPadButton(Size size, String value, {Color? color}) {
    return InkWell(
      highlightColor: Colors.black45,
      onTap: () {
        setState(() {
          display = display + value;
        });
      },
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.33,
        decoration:
        BoxDecoration(border: Border.all(color: Colors.grey, width: 0.025)),
        child: Center(
          child: Text(
            value,
            textScaleFactor: 1.0,
            style: TextStyle(
                color: color ??const Color(0x3300AF5B),
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}