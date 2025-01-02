import 'package:flutter/material.dart';
import 'instruction.dart';
import 'game.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows AppBar to overlay the body
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set custom height for the AppBar
        child: AppBar(
          backgroundColor: Colors.transparent, // Makes the AppBar transparent
          elevation: 0, // Removes shadow
          leading: Padding(
            padding: const EdgeInsets.all(4.0), // Adjust padding if needed
            child: SizedBox(
              width: 80, // Adjust the width of the logo
              height: 80, // Adjust the height of the logo
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
          // Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Character Image
                Image.asset(
                  'assets/character.png', // Replace with your character image path
                  width: 300, // Set desired width
                  height: 300, // Set desired height
                  fit: BoxFit.contain, // Ensures the image fits the specified size
                ),
                const SizedBox(height: 30), // Add spacing between the image and buttons

                // Instructions Button with Image and Custom Font
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InstructionScreen()),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/blue_button.png', // Replace with your button image path
                        width: 150, // Button image width
                        height: 45, // Button image height
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        '설명보기',
                        style: TextStyle(
                          // fontFamily: 'YourFontName', // Replace with your custom font name
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Spacing between buttons

                // Play Game Button with Image and Custom Font
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GameScreen()),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/blue_button.png', // Replace with your button image path
                        width: 150, // Button image width
                        height: 45, // Button image height
                        fit: BoxFit.fill,
                      ),
                      const Text(
                        '게임하기',
                        style: TextStyle(
                          // fontFamily: 'YourFontName', // Replace with your custom font name
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
