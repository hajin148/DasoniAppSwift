import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows AppBar to overlay the body
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set custom height for the AppBar
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0), // Adjust padding for the logo
            child: SizedBox(
              width: 60, // Logo width
              height: 60, // Logo height
              child: Image.asset(
                'assets/main_logo.png', // Replace with your logo image path
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: const SizedBox.shrink(), // No title
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
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
                  // Instructions Image
                  Image.asset(
                    'assets/instructions_image.png', // Replace with your instruction image
                    width: 250, // Adjust width as needed
                    height: 250, // Adjust height as needed
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20), // Spacing between image and text

                  // Instructions Text
                  const Text(
                    '1. 화면에 표시된 음표를 확인하세요.\n'
                        '2. 해당 음표에 맞는 소리를 선택하세요.\n'
                        '3. 게임을 완료하며 실력을 향상시켜 보세요!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30), // Spacing between text and button

                  // Back Button with Image and Custom Font
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Navigate back
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
                          '돌아가기',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold, // Bold text
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
      ),
    );
  }
}
