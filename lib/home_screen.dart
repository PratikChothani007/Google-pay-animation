import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> images = [
    'assets/male1.jpg',
    'assets/male2.jpg',
    'assets/female1.png',
    'assets/female2.png',
  ];
  double topPadding = 0;
  bool isSet = false;
  Size size = Size(0, 0);
  Size avtarSize = Size(50, 50);
  Size avtarCodeSize = Size(10, 10);
  double intialPadding = 0;
  double profileAvtarPaddingTop = 0;
  double profileAvtarPaddingRight = 0;
  double slideDownByPercentageUnit = 0;
  bool isUpSliding = false;
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _controller.addListener(() {
      setState(() {
        topPadding = _animation.value;
        if (topPadding > size.height / 3) {
          profileAvtarPaddingRight =
              (20 + 0.10 * slideDownPercentage(topPadding, size));
          profileAvtarPaddingTop = (intialPadding +
              10 +
              ((size.height / 3 - 100 - 50 - 10) / 100) *
                  slideDownPercentage(topPadding, size));
          avtarSize = Size(50 + 0.40 * slideDownPercentage(topPadding, size),
              50 + 0.40 * slideDownPercentage(topPadding, size));
          if (slideDownPercentage(topPadding, size) > 50) {
            avtarCodeSize = Size(
                10 +
                    120 *
                        (slideDownPercentage(topPadding, size) - 50) *
                        2 /
                        100,
                10 +
                    120 *
                        (slideDownPercentage(topPadding, size) - 50) *
                        2 /
                        100);
            print(avtarCodeSize);
          }
        }
        if (topPadding == size.height / 3) {
          profileAvtarPaddingRight = 20;
          profileAvtarPaddingTop = intialPadding + 10;
          avtarSize = Size(50, 50);
          avtarCodeSize = Size(10, 10);
        }
        if (topPadding == size.height - 50) {
          profileAvtarPaddingRight = 30;
          avtarSize = Size(90, 90);
          avtarCodeSize = Size(130, 130);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(double startingPadding, double endingPadding) {
    _animation = _controller.drive(
      Tween(begin: startingPadding, end: endingPadding),
    );
    _controller.reset();
    _controller.forward();
  }

  void animationBake() {
    _runAnimation(topPadding, size.height / 3);
  }

  double slideDownPercentage(double topPadding, Size size) {
    if (slideDownByPercentageUnit == 0) return 0;
    return (-1 * (size.height / 3 - topPadding) / slideDownByPercentageUnit);
  }

  @override
  Widget build(BuildContext context) {
    if (!isSet) {
      size = MediaQuery.of(context).size;
      intialPadding = MediaQuery.of(context).padding.top;
      topPadding = size.height / 3;
      isSet = true;
      profileAvtarPaddingTop = intialPadding + 10;
      profileAvtarPaddingRight = 20;
      slideDownByPercentageUnit = ((size.height - 50 - size.height / 3) / 100);
    }
    return Scaffold(
        body: GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          if (details.delta.dy > 0) {
            //drag down
            isUpSliding = false;
            if (topPadding < size.height - 50) {
              if (topPadding < size.height / 3) {
                topPadding = topPadding + details.delta.dy;
              } else {
                topPadding = topPadding + details.delta.dy * 0.5;
                profileAvtarPaddingRight =
                    (20 + 0.10 * slideDownPercentage(topPadding, size));
                profileAvtarPaddingTop = (intialPadding +
                    10 +
                    ((size.height / 3 - 100 - 50 - 10) / 100) *
                        slideDownPercentage(topPadding, size));
                avtarSize = Size(
                    50 + 0.40 * slideDownPercentage(topPadding, size),
                    50 + 0.40 * slideDownPercentage(topPadding, size));
                if (slideDownPercentage(topPadding, size) > 50) {
                  avtarCodeSize = Size(
                      10 +
                          120 *
                              (slideDownPercentage(topPadding, size) - 50) *
                              2 /
                              100,
                      10 +
                          120 *
                              (slideDownPercentage(topPadding, size) - 50) *
                              2 /
                              100);
                  print(avtarCodeSize);
                }
              }
            }
          } else {
            //grag up
            isUpSliding = true;
            if (topPadding >= 0) {
              topPadding = topPadding + details.delta.dy;
              if (topPadding > size.height / 3) {
                profileAvtarPaddingRight =
                    (20 + 0.10 * slideDownPercentage(topPadding, size));
                profileAvtarPaddingTop = (intialPadding +
                    10 +
                    ((size.height / 3 - 100 - 50 - 10) / 100) *
                        slideDownPercentage(topPadding, size));
                avtarSize = Size(
                    50 + 0.40 * slideDownPercentage(topPadding, size),
                    50 + 0.40 * slideDownPercentage(topPadding, size));
                if (slideDownPercentage(topPadding, size) > 50) {
                  avtarCodeSize = Size(
                      10 +
                          120 *
                              (slideDownPercentage(topPadding, size) - 50) *
                              2 /
                              100,
                      10 +
                          120 *
                              (slideDownPercentage(topPadding, size) - 50) *
                              2 /
                              100);
                  print(avtarCodeSize);
                }
              }
            }
          }
        });
      },
      onPanEnd: (details) {
        if (isUpSliding) {
          if (topPadding < size.height / 3) {
            _runAnimation(topPadding, 0);
          } else {
            _runAnimation(topPadding, size.height / 3);
          }
        } else {
          if (topPadding < size.height / 3) {
            _runAnimation(topPadding, size.height / 3);
          } else {
            if (topPadding < size.height * 1.5 / 3) {
              _runAnimation(topPadding, size.height / 3);
            } else {
              _runAnimation(topPadding, size.height - 50);
            }
          }
        }
        // if (topPadding < size.height / 10) {
        //   _runAnimation(topPadding, 0);
        // } else if (topPadding > size.height / 10 &&
        //     topPadding < size.height * 1.5 / 3) {
        //   _runAnimation(topPadding, size.height / 3);
        // } else {
        //   _runAnimation(topPadding, size.height - 50);
        // }
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: intialPadding),
            child: Opacity(
                opacity: slideDownPercentage(topPadding, size) < 0
                    ? 0
                    : slideDownPercentage(topPadding, size) < 50
                        ? 0
                        : (slideDownPercentage(topPadding, size) - 50) *
                            2 /
                            100,
                child: bottomSheet(
                    size,
                    ((slideDownPercentage(topPadding, size) - 50) * 2 / 100) ==
                            1
                        ? animationBake
                        : null)),
          ),
          Padding(
            padding: EdgeInsets.only(top: intialPadding),
            child: Opacity(
              opacity: slideDownPercentage(topPadding, size) <= 0
                  ? 1
                  : slideDownPercentage(topPadding, size) > 50
                      ? 0
                      : 1 - (slideDownPercentage(topPadding, size)) * 2 / 100,
              child: Container(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/scan-icon.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bharat',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
                          ),
                          Text(
                            ' pay',
                            style: TextStyle(
                                fontSize: 24, fontStyle: FontStyle.italic),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: profileAvtarPaddingTop,
            right: profileAvtarPaddingRight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(avtarCodeSize.width / 2),
                  child: Container(
                      width: avtarCodeSize.width,
                      height: avtarCodeSize.height,
                      color: Colors.transparent,
                      child: Image.asset(
                        'assets/qr-code2.png',
                        fit: BoxFit.cover,
                      )),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(avtarSize.width / 2),
                  child: Container(
                    width: avtarSize.width,
                    height: avtarSize.height,
                    color: Colors.blue,
                    child: Image.asset(
                      images[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: slideDownPercentage(topPadding, size) <= 0
                ? (size.height * 2 / 3 - 110)
                : (size.height * 2 / 3 - 110) -
                    slideDownPercentage(topPadding, size) *
                        size.height *
                        3 /
                        300,
            child: Opacity(
              opacity: slideDownPercentage(topPadding, size) <= 0
                  ? 1
                  : slideDownPercentage(topPadding, size) > 50
                      ? 0
                      : 1 - (slideDownPercentage(topPadding, size)) * 2 / 100,
              child: Container(
                width: size.width,
                height: size.height / 3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.yellow.withOpacity(0), Colors.yellow])),
                child: SvgPicture.asset('assets/home_banner.svg'),
              ),
            ),
          ),
          Positioned(
            top: topPadding,
            child: frontSheet(size, topPadding <= 0 ? true : false),
          )
        ],
      ),
    ));
  }

  Widget bottomSheet(Size size, Function animation) {
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height / 3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue.withOpacity(0),
                  Colors.blue[400].withOpacity(0.5)
                ])),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: animation,
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          size: 30,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.more_vert,
                        size: 30,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      'Pratik Chothani',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text('+91 9999999999'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: Text('exampleupis@oksbi'),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'BANK ACCOUNTS AND CARDS',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    'SBI',
                    style: TextStyle(color: Colors.blue),
                  )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'State Bank of India...9090',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green[400],
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Defaul bank account'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.share_outlined,
                size: 30,
                color: Colors.blue,
              ),
              title: Text('Invite and earn'),
              subtitle: Text('Invite and earn'),
              trailing: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  'Invite',
                  style: TextStyle(color: Colors.grey),
                )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Colors.blue,
              ),
              title: Text('Setting'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.help_outline_rounded,
                size: 30,
                color: Colors.blue,
              ),
              title: Text('Help & feedback'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                  0,
                  1
                ],
                        colors: [
                  Colors.blue.withOpacity(0),
                  Colors.blue[200].withOpacity(0.5)
                ]))),
          )
        ],
      ),
    );
  }

  Widget frontSheet(Size size, bool canScroll) {
    return Container(
      constraints: BoxConstraints(
          minWidth: size.width, minHeight: size.height, maxWidth: size.width),
      height: size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, -5),
            )
          ]),
      child: SingleChildScrollView(
        physics: canScroll ? null : NeverScrollableScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(right: 25, left: 25, top: 15),
                child: Text(
                  'People',
                  style: TextStyle(fontSize: 24),
                )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(children: [
                PaymentAvtar(size, images[1]),
                PaymentAvtar(size, images[3]),
                PaymentAvtar(size, images[1]),
                PaymentAvtar(size, images[3]),
                PaymentAvtar(size, images[0]),
                PaymentAvtar(size, images[2]),
                PaymentAvtar(size, images[0]),
                PaymentAvtar(size, images[2]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentAvtar extends StatelessWidget {
  Size size;
  String image;
  PaymentAvtar(this.size, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width - 40) / 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue[200], shape: BoxShape.circle),
              child: Image.asset(image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Person'),
          )
        ],
      ),
    );
  }
}
