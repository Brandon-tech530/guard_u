import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '       Welcome To GUARD_U\n',
                    style: TextStyle(fontSize: 23, color: Colors.green[200]),
                  ),
                  const TextSpan(
                    text:
                        'Your personal companion, guarding you against theft and emergencies\n',
                    style: TextStyle(fontSize: 18),
                  ),
                  const TextSpan(
                    text: 'Stay Alert with real-time Alerts\n',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const TextSpan(
                    text: '1) Get notified when entering red zones with high theft cases\n2) Stay aware of your surroundings for added safety',
                    style: TextStyle(fontSize: 18),
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
