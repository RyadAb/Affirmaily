import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: 'AFFIRMAILY',
        description:
            "Welcome to Affirmaily, The App that lets you forge your reality !",
        pathImage: "assets/images/logo.png",
        backgroundColor: Color(0xFF009688),
      ),
    );
    slides.add(
      new Slide(
        title: "THOUGHT SEED",
        description:
            "You can think of affirmations as planting thought seeds in your brain garden. The more you way them, the more they grow and blossom.",
        pathImage: "assets/images/thoughtSeed.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "THOUGHT PATTERNS",
        description:
            "Affirmations can alter your thought patterns and belief system, they help you reprogram your mind so that it is a network of beneficial synapses.",
        pathImage: "assets/images/thoughtPatterns.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "ALTER YOUR REALITY",
        description:
            "A good set of affirmations will help you to consciously shape the thoughts and words that reflect the reality you want to see.",
        pathImage: "assets/images/alterYourReality.png",
        widthImage: 650.0,
        heightImage: 320.0,
        backgroundColor: Color(0xfffbf360c),
      ),
    );
  }

  void onDonePress() {
    Navigator.popAndPushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
