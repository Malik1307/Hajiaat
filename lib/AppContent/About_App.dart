import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop/AppContent/color.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsAppChat(String phoneNumber) async {
  final whatsappUrl = Uri.parse("whatsapp://send?phone=$phoneNumber");
  final whatsappWebUrl = Uri.parse("https://wa.me/$phoneNumber");

  try {
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else if (await canLaunchUrl(whatsappWebUrl)) {
      await launchUrl(whatsappWebUrl);
    } else {
      throw 'Could not launch WhatsApp chat with $phoneNumber';
    }
  } catch (e) {
    print('Error launching WhatsApp: $e');
  }
}

Future<void> openFacebookProfile(String profileUrl) async {
  final fbAppUrl = Uri.parse("fb://profile/100009033161452");
  final fbWebUrl = Uri.parse(profileUrl);

  try {
    if (await canLaunchUrl(fbAppUrl)) {
      await launchUrl(fbAppUrl);
    } else if (await canLaunchUrl(fbWebUrl)) {
      await launchUrl(fbWebUrl);
    } else {
      throw 'Could not launch Facebook profile';
    }
  } catch (e) {
    print('Error launching Facebook: $e');
  }
}

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
var ScreenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:t,
      appBar: AppBar(
        backgroundColor: t,
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Created by Malik at 8/1/2024",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Image.asset("Images/l-intro-1679582548.jpg"),
              // SizedBox(height: 30),
              SizedBox(height: ScreenHeight*0.15,),
              Text(
                "For more information",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                "(Salary With Euros/Dollars Only)",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => openFacebookProfile(
                      "https://www.facebook.com/profile.php?id=100009033161452",
                    ),
                    icon: Icon(
                      Icons.facebook,
                      size: 60,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () => openWhatsAppChat("+201064189695"),
                    icon: Icon(
                      FontAwesomeIcons.whatsapp,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.linkedin,
                          size: 60,
                          color: Colors.lightBlue,
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        child: Image.asset("Images/239-label__39582.png"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop/AppContent/color.dart';
import 'package:url_launcher/url_launcher.dart';
// Future<void> openWhatsAppChat(String phoneNumber) async {
//   final whatsappUrl = "whatsapp://send?phone=$phoneNumber";
//   if (await canLaunch(whatsappUrl)) {
//     await launch(whatsappUrl);
//   } else {
//     throw 'Could not launch WhatsApp chat with $phoneNumber';
//   }
// }
// // Future<void> openFacebookProfile(String profileUrl) async {
// //   final fbUrl = "fb://profile/100009033161452"; // Replace YOUR_PROFILE_ID with actual Facebook profile ID
// //   if (await canLaunch(fbUrl)) {
// //     await launch(fbUrl);
// //   } else {
// //     if (await canLaunch(profileUrl)) {
// //       await launch(profileUrl);
// //     } else {
// //       throw 'Could not launch Facebook profile';
// //     }
// //   }
// // }


class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: t,
      appBar: AppBar(
        backgroundColor: t,
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Created by Malik at 8/1/2024 ",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset("Images/l-intro-1679582548.jpg"),
              // SizedBox(height: 20,),
              // Spacer(),
          // SizedBox(height: 30,),

          SizedBox(height: 30,),
              Text(
                "For more information",
                style: TextStyle(color: a, fontSize: 25),
              ),
              Text(
                "(Salary With Euros/Dollars Only)",
                style: TextStyle(color: g, fontSize: 20),
              ),
          
              SizedBox(
                height: 30,
              ),
          //Enable Links
// SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.facebook,
                        size: 60,
                        color: Colors.blue,
                      )),
                  // Spacer(),
                  IconButton(
                      onPressed:(){},
                      icon: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 60,
                        color: Colors.green,
                      )),
                  // Spacer(),
                        
                  Stack( alignment: Alignment.topRight,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.linkedin,
                            size: 60,
                            color: Colors.lightBlue,
                          )),
                      Container(
                        height: 35,
                        width: 35,
                        child: Image.asset(
                          "Images/239-label__39582.png",
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */