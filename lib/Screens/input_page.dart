import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../Components/BottomContainer_Button.dart';
import '../Components/Icon_Content.dart';
import '../Components/Reusable_Bg.dart';
import '../Components/RoundIcon_Button.dart';
import '../calculator_brain.dart';
import '../constants.dart';
import 'Results_Page.dart';

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

//ENUMERATION : The action of establishing number of something , implicit way
enum Gender {
  male,
  female,
}

class _InputPageState extends State<InputPage> {

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

    /// Loads a banner ad.
    void loadAd() {
      _bannerAd = BannerAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            setState(() {
              _isLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            // Dispose the ad here to free resources.
            ad.dispose();
          },
        ),
      )..load();
    }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAd();
  }

  //by default male will be selected

  late Gender selectedGender = Gender.male;
  int height = 180;
  int weight = 50;
  int age = 20;
  var cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: ReusableBg(
                      colour: selectedGender == Gender.male
                          ? kactiveCardColor
                          : kinactiveCardColor,
                      cardChild: IconContent(
                          myicon: FontAwesomeIcons.mars, text: 'MALE'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    child: ReusableBg(
                      colour: selectedGender == Gender.female
                          ? kactiveCardColor
                          : kinactiveCardColor,
                      cardChild: IconContent(
                          myicon: FontAwesomeIcons.venus, text: 'FEMALE'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableBg(
              colour: kactiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: klabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: kDigitTextStyle,
                      ),
                      Text(
                        'cm',
                        style: klabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: ksliderInactiveColor,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 35.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableBg(
                    colour: kactiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: klabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kDigitTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableBg(
                    colour: kactiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'AGE',
                          style: klabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kDigitTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(width: 15.0),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomContainer(
            text: 'CALCULATE',
            onTap: () {
              Calculate calc = Calculate(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmi: calc.result(),
                    resultText: calc.getText(),
                    advise: calc.getAdvise(),
                    textColor: calc.getTextColor(),
                  ),
                ),
              );
            },
          ),
          (_bannerAd!=null)?Align(alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),):Text("No ads")
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.favorite,
      //     color: Colors.pink,
      //     size: 23.0,
      //   ),
      //   backgroundColor: kactiveCardColor,
      // ),
    );
  }
}
