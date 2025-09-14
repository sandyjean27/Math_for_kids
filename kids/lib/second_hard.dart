import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'second.dart';

class SecondHard extends StatefulWidget {
  @override
  _SecondHardState createState() => _SecondHardState();
}

class _SecondHardState extends State<SecondHard> {
  int _n1 = 0;
  int _n2 = 0;
  int _min = 6;
  int _max = 10;
  int _lives = 5; // Set initial lives to 5
  int _timer = 10; // Countdown timer
  String _remarks = "";
  late Timer _countdownTimer;
  List<int> _choices = [];

  @override
  void initState() {
    super.initState();
    _generateQuestion();
    _startTimer();
  }

  void _generateQuestion() {
    _n1 = Random().nextInt(_max - _min + 1) + _min;
    _n2 = Random().nextInt(_max - _min + 1) + _min;

    int correctAnswer = _n1 + _n2;
    _choices = [correctAnswer];
    while (_choices.length < 4) {
      int randomChoice = Random().nextInt(_max * 2) + _min;
      if (!_choices.contains(randomChoice)) {
        _choices.add(randomChoice);
      }
    }
    _choices.shuffle();
  }

  void _startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 2), (timer) { // Timer slows down to 2 seconds
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          _countdownTimer.cancel();
          _handleTimeout();
        }
      });
    });
  }

  void _handleTimeout() {
    setState(() {
      _remarks = "Time's up!";
      _lives--;
      if (_lives > 0) {
        _resetForNextQuestion();
      } else {
        _showGameOverDialog();
      }
    });
  }

  void _checkAnswer(int selectedAnswer) {
    setState(() {
      if (selectedAnswer == _n1 + _n2) {
        _remarks = "Correct!";
        _resetForNextQuestion();
      } else {
        _remarks = "Wrong!";
        _lives--;
        if (_lives > 0) {
          _resetForNextQuestion();
        } else {
          _showGameOverDialog();
        }
      }
    });
  }

  void _resetForNextQuestion() {
    _generateQuestion();
    _timer = 10;
    _startTimer();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: const Text("You ran out of lives. Try again!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _lifeIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        5, // Display 5 hearts for 5 lives
        (index) => Icon(
          Icons.favorite,
          color: index < _lives ? Colors.blue : Colors.grey,
          size: 30,
        ),
      ),
    );
  }

  Widget _choiceButton(int answer) {
    return GestureDetector(
      onTap: () => _checkAnswer(answer),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.cyan],
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

  Widget _background() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _lifeIndicator(),
                const SizedBox(height: 20),
                Text(
                  "Time Left: $_timer s",
                  style: GoogleFonts.pressStart2p(
                    fontSize: 24,
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
                Text(
                  '$_n1 + $_n2 = ?',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: _choices
                      .map((answer) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _choiceButton(answer),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  _remarks,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                  MaterialPageRoute(builder: (context) => Second()), // Navigate to Second screen
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
