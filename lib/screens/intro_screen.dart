//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  final String title;

  const IntroPage({super.key, this.title = 'Default Title'});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
              print("$index, $onLastPage");
            });
          },
          children: [
            Flexible(
              child: 
            Container(
              color: Colors.pink,
              child: Image.asset('assets/sleep.png'),
            ),
            ),
            Container(
              color: Colors.pink,
              child: Image.asset('assets/exercise.png'),
            ),
            Container(
              color: Colors.pink,
              child: Image.asset('assets/work.png'),
            ),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'tasks');
                },
              ),
              Text(
                'skip',
                style: TextStyle(color: Colors.grey)
              ),
      
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: SwapEffect(
                    dotColor: Colors.blue,
                    activeDotColor: Colors.white,
                    type: SwapType.yRotation),
              ),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'tasks');
                      },
                      child: Text('done', style: TextStyle(color: Colors.grey)))
                  : GestureDetector(
                      onTap: () {
                        controller.nextPage(
                            duration: Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.grey),
                    )
            ],
          ),
        )
      ]),
    );
  }
}
