import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(
              'Dice',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  int player1Score = 0;
  int player2Score = 0;
  String winner = '';
  bool isGameOver = false;

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
      calculateScores();
    });
  }

  void calculateScores() {
    if (!isGameOver) {
      player1Score += leftDiceNumber;
      player2Score += rightDiceNumber;

      if (player1Score >= 100 || player2Score >= 100) {
        // Determine the winner
        if (player1Score >= 100 && player2Score >= 100) {
          winner = "It's a tie!";
        } else if (player1Score >= 100) {
          winner = "Player 1 wins!";
        } else {
          winner = "Player 2 wins!";
        }

        // Set the game over flag
        isGameOver = true;

        // Delay and restart the game after 2 seconds
        Future.delayed(Duration(seconds: 2), () {
          resetGame();
        });
      }
    }
  }

  void resetGame() {
    setState(() {
      isGameOver = false;
      player1Score = 0;
      player2Score = 0;
      winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Player 1 Score: $player1Score',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  child: Image.asset(
                    'images/dice$leftDiceNumber.png',
                  ),
                  onPressed: () {
                    changeDiceFace();
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Image.asset('images/dice$rightDiceNumber.png'),
                  onPressed: () {
                    changeDiceFace();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Player 2 Score: $player2Score',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          if (isGameOver)
            Text(
              winner,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
        ],
      ),
    );
  }
}
