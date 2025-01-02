import 'package:flutter/material.dart';

class EndGame extends StatelessWidget {
  final int score;

  const EndGame({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the AppBar to overlay the body
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set custom height for the AppBar
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
          leading: Padding(
            padding: const EdgeInsets.all(4.0), // Adjust padding for the logo
            child: SizedBox(
              width: 80, // Logo width
              height: 80, // Logo height
              child: Image.asset(
                'assets/main_logo.png', // Replace with your logo image path
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: const SizedBox.shrink(), // No title
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png', // Replace with your background image path
              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the score
                Text(
                  '점수: $score',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Return to Main Menu Button
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/blue_button.png', // Button background image
                        width: 150, // Button width
                        height: 45, // Button height
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        '다시하기', // Button text
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
