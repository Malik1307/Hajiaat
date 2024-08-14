import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/AppContent/color.dart';
import 'package:shop/Constants/Componants.dart';
import 'package:shop/Login/Cubit/Cubit.dart';
import 'package:shop/Login/Cubit/CubitStates.dart';
import 'package:shop/Login/Login_Screen.dart';
import 'package:shop/SharedPref/CasheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//DEBUG AND RELEASE

class BoardingModel {
  String Title;
  final String Body;
  final String Imagepath;

  BoardingModel({this.Title = "", required this.Body, required this.Imagepath});
}

class Onboarding extends StatefulWidget {
  Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

// List<String> OnBoardingimages = [
//   "Images/1.png",
//   "Images/2.png",
//   "Images/3.png",
// ];
// List<String> OnBoardingText = [
//   "Title1",
//   "Text2",
//   "Text3",
// ];
List<BoardingModel> OnBoardingList = [
  BoardingModel(
      Title: "All You Need in One Place",
      Body:
          "Explore our vast collection and find exactly what you're looking for. Shopping has never been this easy and fun!",
      Imagepath: "Images/1.png"),
  BoardingModel(
      Title: "One-Click Payments",
      Body:
          "Pay easily with our range of payment options. We accept all major payment methods.",
      Imagepath: "Images/2.png"),
  BoardingModel(
      Title: "Fast Delivery",
      Body:
          "Get your orders delivered quickly and efficiently right to your doorstep. Shop now and enjoy fast and reliable delivery!",
      Imagepath: "Images/3.png"),
];

class _OnboardingState extends State<Onboarding> {
  var PageviewController = PageController();
  bool IsLastPage = false;

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        actions: [
          DefaultTextButton(
            onPressed: () {
              AHA.SavaData(key: "Board", value: true).then((value) {
                if (value) {
                  NavigatReplace(context, LoginScreen());
                  
                }
              }).catchError((error) {
                print("Error saving data: ${error.toString()}");
              });
            },
            text: "Skip",
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == OnBoardingList.length - 1) {
                    IsLastPage = true;
                  } else {
                    IsLastPage = false;
                  }
                  setState(() {});
                },
                controller: PageviewController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    OnBoardingWidget(OnBoardingList[index]),
                itemCount: OnBoardingList.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: PageviewController,
                  count: OnBoardingList.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(159, 18, 87, 115),
                    dotHeight: 12,
                    dotWidth: 17,
                    expansionFactor: 3,
                    spacing: 8,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (IsLastPage) {
                      AHA.SavaData(key: "Board", value: true).then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                      });
                    } else {
                      PageviewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  backgroundColor: Additional2,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Dom,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget OnBoardingWidget(BoardingModel Object) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        Object.Title,
        style: TextStyle(
          color: Additional2,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'NewFont',
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Expanded(
        child: Image.asset(
          Object.Imagepath,
          fit: BoxFit.contain, // Or BoxFit.cover depending on your need
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        Object.Body,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'NewFont',
        ),
      ),
    ],
  );
}
