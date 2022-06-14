import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:project/provider/loginprovider.dart';
import 'package:project/widget/color.dart';
import 'package:project/widget/smalltext.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/checklistbg.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkTeal,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Safe Trip!'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                  FlipCard(
                    // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL, // default
                    front: Container(
                      child: SmallText(text: 'Click to Sign Out', color: AppColor.light, size: 25,),
                    ),
                    back: Container(
                      height: 100,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(text: "Sign Out", color: AppColor.light, size: 25,),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.logout_outlined),
                            onPressed: () {
                              Provider.of<LoginProvider>(context, listen: false)
                                  .signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            )),
      ),
    );
  }
}
