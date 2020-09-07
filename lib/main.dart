import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Craps Game'),
          backgroundColor: Colors.red,
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
  var leftDie = 1;
  var rightDie = 1;
  var crapsWon = 0;
  var crapsLost = 0;
  var currentTotal = 0;
  var crapsNumber = 0;
  var gameMessage = '';
  var isRollButtonVisible = false;
  var isNewButtonVisible = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Visibility(
                visible: isNewButtonVisible,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 10,
                      onPressed: () {
                        setState(() {
                          newGame();
                        });
                      },
                      child: const Text(
                        'New Game',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isRollButtonVisible,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 10,
                      onPressed: () {
                        setState(() {
                          rollTheDice();
                        });
                      },
                      child: Text(
                        'Roll Dice',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'Your craps number:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              trailing: Text(
                crapsNumber.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Visibility(
            visible: crapsNumber > 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Image.asset('images/dice$leftDie.png'),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Image.asset('images/dice$rightDie.png'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              gameMessage,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Text('Games won: $crapsWon'),
          Text('Games lost: $crapsLost'),
        ],
      ),
    );
  }

  void newGame() {
    leftDie = 1;
    rightDie = 1;
    crapsNumber = 0;
    gameMessage = '';
    isRollButtonVisible = true;
    isNewButtonVisible = false;
  }

  void rollTheDice() {
    leftDie = Random().nextInt(6) + 1;
    rightDie = Random().nextInt(6) + 1;

    var total = leftDie + rightDie;

    // if new game
    if (crapsNumber == 0) {
      if (total == 7 || total == 11) {
        gameMessage = 'You won!';
        crapsWon++;
        isRollButtonVisible = false;
        isNewButtonVisible = true;
      } else {
        crapsNumber = total;
      }
    } else {
      // not new game. check if they rolled a winning number or crapped out.
      if (total == crapsNumber) {
        gameMessage = 'You won!';
        crapsWon++;
        isRollButtonVisible = false;
        isNewButtonVisible = true;
      } else if (total == 7 || total == 11) {
        gameMessage = 'You lost!';
        crapsLost++;
        isRollButtonVisible = false;
        isNewButtonVisible = true;
      }
    }
  }
}
