import 'package:blott/news_screen.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  final String firstName;
  final String lastName;

  const Onboarding({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/Icon.png', width: 98, height: 98),
            SizedBox(height: 24),
            Text(
              'Get the most out of Blott ✅',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Allow notifications to stay in the loop with\nwith your payments,requests and groups',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ElevatedButton(
          onPressed: () {
            showAdaptiveDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(
                    '"Blott" Would Like to Send You Notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  content: Text(
                    'Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text('Don’t Allow'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle the permission logic here
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>  NewsScreen(firstName:widget.firstName ,),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text('Allow'),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF523AE4),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
