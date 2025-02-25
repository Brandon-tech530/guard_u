import 'package:flutter/material.dart';
import 'package:guard_u/Screens/login.dart';
import 'package:guard_u/Screens/pages/intro_page_1.dart';
import 'package:guard_u/Screens/pages/intro_page_2.dart';
import 'package:guard_u/Screens/pages/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //controller to keep track of which page we're on
  final PageController _controller = PageController();

  //keep track of if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      // page view
      PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            onLastPage = (index == 2);
          });
        },
        children: const [
          IntroPage1(),
          IntroPage2(),
          IntroPage3(),
        ],
      ),

      // dot indicators
      Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // skip
              GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow:  [
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
                    child: const Center(child: Text('Skip'))
                    )
                    ),

              //dot indicator
              SmoothPageIndicator(controller: _controller, count: 3),

              //next or done
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LogIn();
                        }));
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow:  [
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
                        child: const Center(child: Text('Done'))),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow:  [
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
                        child: const Center(child: Text('Next'))),
                    ),
            ],
          ))
    ]));
  }
}
