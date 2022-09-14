import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hulace/utils/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../get_started/getstarted_auth.dart';



class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GetStartedAuth()),
    );
  }



  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize:15,fontWeight: FontWeight.w300,color: whiteColor);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,color: whiteColor),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: primaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: primaryColor,


      pages: [
        PageViewModel(
          title: "Finding vendors for events\nis became easy.",
          body: "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit leo felis congue elit leo.",
          image: Image.asset("assets/images/onboard1.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(

          title: "Instantly chat with vendors\nand book events.",
          body: "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit leo felis congue elit leo.",
          image: Image.asset("assets/images/onboard2.png"),
          decoration: pageDecoration,
        ),
        
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back,color: primaryColor,),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: primaryColor,)),
      next: const Icon(Icons.arrow_forward,color: primaryColor,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: primaryColor,)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: primaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

