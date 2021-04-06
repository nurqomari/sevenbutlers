import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'data.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: StepProgressIndicator(
                    padding: 4,
                    totalSteps: 6,
                    currentStep: slideIndex + 1,
                    unselectedColor: Colors.grey[200],
                    selectedColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 600,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      SlideTile(
                        imagePath: mySLides[0].getImageAssetPath(),
                        title: mySLides[0].getTitle(),
                        desc: mySLides[0].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[1].getImageAssetPath(),
                        title: mySLides[1].getTitle(),
                        desc: mySLides[1].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[2].getImageAssetPath(),
                        title: mySLides[2].getTitle(),
                        desc: mySLides[2].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[3].getImageAssetPath(),
                        title: mySLides[3].getTitle(),
                        desc: mySLides[3].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[4].getImageAssetPath(),
                        title: mySLides[4].getTitle(),
                        desc: mySLides[4].getDesc(),
                      ),
                      SlideTile(
                        imagePath: mySLides[5].getImageAssetPath(),
                        title: mySLides[5].getTitle(),
                        desc: mySLides[5].getDesc(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: slideIndex != 5
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 20, 10),
                    child: MaterialButton(
                      onPressed: () {
                        controller.animateToPage(slideIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      textColor: Colors.white,
                      color: Colors.black,
                      child: SizedBox(
                          width: 250,
                          child: slideIndex == 0
                              ? Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          100, 10, 20, 10),
                                      child: Text(
                                        "START",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          250, 7, 20, 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 24.0,
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                    )
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          100, 10, 20, 10),
                                      child: Text(
                                        "NEXT",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          250, 7, 20, 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 24.0,
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                    )
                                  ],
                                )),
                      height: 45,
                      minWidth: 401.2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                  ))
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 20, 10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false);
                      },
                      textColor: Colors.white,
                      color: Colors.black,
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          "FINISH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      height: 45,
                      minWidth: 401.2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                    ),
                  ))),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 60,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
