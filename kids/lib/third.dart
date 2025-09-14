import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add Google Fonts package
import 'third_easy.dart';
import 'third_medium.dart';
import 'third_hard.dart';

class Third extends StatelessWidget {
  // A reusable button widget with 3D effect styling
  Widget mathButton({
    required String text,
    required Color startColor,
    required Color endColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.pressStart2p(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "Math for Kids" Title
              Column(
                children: [
                  Text(
                    'Math for Kids',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 28.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Fun and easy learning!',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              // Buttons for Math Operations
              mathButton(
                text: 'EASY',
                startColor: Colors.blue,
                endColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdEasy()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              mathButton(
                text: 'MEDIUM',
                startColor: Colors.green,
                endColor: Colors.lightGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdMedium()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              mathButton(
                text: 'HARD',
                startColor: Colors.orange,
                endColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdHard()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Go back to the previous screen
        },
        backgroundColor: Colors.redAccent,
        child: Text(
          "Back",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
