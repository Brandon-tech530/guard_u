import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
        child: Container(
            margin: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                //darker shadow at bottom right
                BoxShadow(
                  color: Colors.blue.shade700,
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
                //lighter shadow at top left
                BoxShadow(
                  color: Colors.blue.shade100,
                  offset: const Offset(-4, -4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sos at your finger-tips\n',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.black),
                    ),
                    TextSpan(
                      text:
                          '1) Send emergency alert to your trusted contacts\n2) Notify relevant authorities instantly  in critical situation\n3) Uses speech detect to send sos\n',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextSpan(
                      text: 'Smart location Assistance\n',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold , color: Colors.black),
                    ),
                    TextSpan(
                      text: '1) Uses your location to keep you informed and safe\n2) explore a custom map with potential risk zones highlighted',
                      style: TextStyle(fontSize: 18,),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
}