import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:hero/fourth.dart';
import 'fourth_medium.dart'; // Import the Medium level screen

class FourthEasy extends StatefulWidget {
  @override
  _FourthEasyState createState() => _FourthEasyState();
}

class _FourthEasyState extends State<FourthEasy> {
  int _n1 = 0;
  int _n2 = 0;
  int _min = 1;
  int _max = 3;
  int _lives = 5; // Set lives to 5
  int _questionIndex = 0;
  int _correctAnswers = 0; // Track correct answers
  String _remarks = "";
  List<Map<String, int>> _questions = [];
  List<int> _choices = [];

  @override
  void initState() {
    super.initState();
    _generateQuestions();
    _generateQuestion();
  }

  // Generate 10 questions for the level
  void _generateQuestions() {
    for (int i = 0; i < 10; i++) {
      int n1 = Random().nextInt(_max - _min + 1) + _min;
      int n2 = Random().nextInt(_max - _min + 1) + _min;
      _questions.add({'n1': n1, 'n2': n2});
    }
  }

  // Generate the current question and possible answers
  void _generateQuestion() {
    if (_questionIndex < _questions.length) {
      _n1 = _questions[_questionIndex]['n1']!;
      _n2 = _questions[_questionIndex]['n2']!;
    }

    // Generate the correct answer using multiplication
    int correctAnswer = _n1 * _n2;

    // Generate 3 random choices, one of which is the correct answer
    _choices = [correctAnswer];
    while (_choices.length < 4) {
      int randomChoice = Random().nextInt(_max * 2) + 1;
      if (!_choices.contains(randomChoice)) {
        _choices.add(randomChoice);
      }
    }

    // Shuffle the choices to randomize the order
    _choices.shuffle();
  }

  // Check the answer
  void _checkAnswer(int selectedAnswer) {
    setState(() {
      if (selectedAnswer == _n1 * _n2) { // Change addition to multiplication here
        _remarks = "Correct!";
        _correctAnswers++; // Increment correct answers
        if (_correctAnswers == 10) {
          // If all questions are correct, proceed to next level (medium)
          _showResultDialog("Congratulations!", "You answered all questions correctly!\nProceeding to Medium Level.");
        } else if (_questionIndex < _questions.length - 1) {
          _questionIndex++;
          _generateQuestion();
        }
      } else {
        _remarks = "Wrong!";
        _lives--;
        if (_lives == 0) {
          _showResultDialog("Game Over", "You ran out of lives. Try again!");
        } else {
          // Proceed to next question
          if (_questionIndex < _questions.length - 1) {
            _questionIndex++;
            _generateQuestion();
          }
        }
      }
    });
  }

  // Show result dialog
  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (_correctAnswers == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourthMedium()), // Navigate to Medium Level
                  );
                } else {
                  Navigator.pop(context); // Close the game and return to the previous screen
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Heart-shaped life indicator
  Widget _lifeIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        _lives,
        (index) => Icon(
          Icons.favorite,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }

  // Gradient button for choices
  Widget _choiceButton(int answer) {
    return GestureDetector(
      onTap: () => _checkAnswer(answer),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
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
              '$answer',
              style: GoogleFonts.pressStart2p(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Gradient background
  Widget _background() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blueAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          _background(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Life indicator at the top right
                _lifeIndicator(),
                const SizedBox(height: 20),
                // "Multiplication - Easy" title
                Text(
                  "Multiplication - Easy",
                  style: GoogleFonts.pressStart2p(
                    fontSize: 28,
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
                const SizedBox(height: 20),
                // Question display
                Text(
                  '$_n1 x $_n2 = ?',
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(height: 20),
                // Display choices for the answer
                Column(
                  children: _choices.map((answer) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _choiceButton(answer),
                  )).toList(),
                ),
                const SizedBox(height: 20),
                // Display remarks (correct or wrong)
                Text(
                  _remarks,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Fourth()), // Navigate to Second screen
                );
              },
              child: Text(
                "Back",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 196, 190, 190), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
