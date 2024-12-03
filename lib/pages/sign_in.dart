import 'package:bestloop_app/shared.dart';
import 'package:flutter/material.dart';
import 'package:bestloop_app/pages/sign_in2.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background21.png',
              fit: BoxFit.cover,
            ),
          ),
          // Smaller image and buttons
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Smaller image in the middle
                Center(
                  child: Image.asset(
                    'assets/Vector (3).png',
                    width: 170,
                    height: 120,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Best Loop',
                  style: TextStyle(
                    fontSize: 24, // Font size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.white, // Text color
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BestLoopButton(
                        text: "Create an account",
                        onPressed: () {
                          print("Create an account pressed!");
                        },
                      ),
                      SizedBox(height: 12), // Spacing between buttons
                      BestLoopButton(
                        text: "Login",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn2(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40), // Add some space at the very bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
