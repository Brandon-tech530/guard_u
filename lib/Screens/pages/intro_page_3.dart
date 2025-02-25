import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
                    const TextSpan(
                      text: 'Before you get started\n',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const TextSpan(
                      text:
                          '1) Grant location permission for accurate alert\n2) Add your emergency contact for quick communication\n3) Be informed and prepared wherever you go\nYour safety Matters. Let\'s logIn with your account details.\n',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextSpan(
                      text:
                          'Thank You for chosing Us.',
                      style: TextStyle(fontSize: 18, color: Colors.green[200]),
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