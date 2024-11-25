import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for email functionality

import '../../controller/home_screen/home_screen_controller.dart';
import '../../controller/splash_screen/screen_splash.dart';
import '../../core/colors.dart';
import '../../core/constant.dart';
import '../../widgets/widgets.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({super.key});
  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  functionText(appName, kWhiteColor, FontWeight.bold, 35),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  functionText(
                      'Music Player', kWhiteColor, FontWeight.bold, 25),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: <Widget>[
                      functionTextButton(() {}, 'Notifications'),
                      Obx(() {
                        return Switch(
                          activeTrackColor: kRoseColor,
                          activeColor: kWhiteColor,
                          inactiveTrackColor: Colors.white,
                          value: _homeScreenController.notification.value,
                          onChanged: (bool value) {
                            _homeScreenController.notification.value = value;
                            audioPlayer.showNotification = value;
                          },
                        );
                      })
                    ],
                  ),
                  functionTextButton(() {
                    Share.share(
                        ""); // 'https://play.google.com/store/apps/details?id=com.musik.music_player');
                  }, 'Share'),
                  functionTextButton(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Privacy Policy'),
                            content: const SingleChildScrollView(
                              child: Text(privacyPolicyContent),
                            ),
                            actions: <Widget>[
                              Center(
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.close)),
                              )
                            ],
                          );
                        });
                  }, 'Privacy Policy'),
                  functionTextButton(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(12),
                            title: ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              leading: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/images/musicIcon1.png'),
                              ),
                              title: functionText('Play\nMusic Player',
                                  Colors.black, FontWeight.bold, 20),
                              subtitle: const Text(
                                  'It is an ad-free Music Player that plays all local storage music.'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  showLicensePage(
                                      context: context,
                                      applicationName: 'MusiQ',
                                      applicationIcon: Image.asset(
                                        'assets/images/app_logo.png',
                                        width: 50,
                                        height: 50,
                                      ));
                                },
                                child: const Text('View License'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    _showGetInTouchSheet(context);
                                  },
                                  child: const Text("Get In Touch")),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Close'))
                            ],
                          );
                        });
                  }, 'About'),
                  functionTextButton(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Really'),
                          content: const Text('Do you want to close the app?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: const Text('Yes'))
                          ],
                        );
                      },
                    );
                  }, 'Exit'),
                ],
              ),
              Column(
                children: <Widget>[
                  functionText('Version', Colors.white, FontWeight.bold, 15),
                  functionText('1.0.0', Colors.white, FontWeight.bold, 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Sheet Function
  void _showGetInTouchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // User Icon and Name
              ListTile(
                leading: Icon(Icons.person, color: Colors.blue, size: 40),
                title: Text(
                  'ABHIRAM M', // Replace with your name
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle:
                    Text('Jr Flutter Developer'), // Replace with your job role
              ),
              Divider(),

              // Email with clickable link
              ListTile(
                leading: Icon(Icons.email, color: Colors.red, size: 30),
                title: GestureDetector(
                  onTap: () {
                    _launchEmail(
                        'abhiramm95@gmail.com'); // Replace with your email
                  },
                  child: Text(
                    'abhiramm95@gmail.com', // Replace with your email
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // OK Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // // Function to launch email app
  // void _launchEmail(String email) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //     queryParameters: {
  //       'subject': 'Hello there!', // Optional subject line
  //     },
  //   );
  //
  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     throw 'Could not launch email';
  //   }
  // }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello there!', // Optional subject line
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // This will print an error to the console if the email doesn't launch
      print('Could not launch $emailUri');
      // Optional: Display an error message to the user
      Get.snackbar(
        "Could not open email client",
        "",
        icon: const Icon(Icons.add_alert),
        snackPosition:
            SnackPosition.BOTTOM, // Or other positions like TOP, etc.
      ); // ScaffoldMessenger.of().showSnackBar(
      //   SnackBar(content: Text('Could not open email client')),
      // );
    }
  }
}
