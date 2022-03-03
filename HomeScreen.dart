// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

// Done by: Bruce Reece
// Topic:   Tic Tac Toe
// Date:    02/16/2022

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//////////////////////////////////////////////////////////////////Functionality
class _MyHomePageState extends State<MyHomePage> {
  var boxInitial = List.filled(9, '', growable: false); //When app is open all
  // squares will be blank

  String whosTurn = "Choose a square!";
  String xTurn = "Player's Turn";
  String oTurn = "Computer's Turn";
  String x = 'X'; // player's turn
  String o = 'O'; // computer's turn
  var win = 0;
  var turn = 'X'; // Initialize turn to x so player plays first

// Scores counter
  var humanCounter = 0;
  var computerCounter = 0;
  var tieCounter = 0;

  // Score Bored
  var xWins = "0";
  var oWins = "0";
  var ties = "0";

  // Back end Board
  var board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  // Random move
  var random = Random();

  //var reset score
  void _resetScore() {
    setState(() {
      xWins = "0";
      oWins = "0";
      ties = "0";
    });
  }

  //////////////////////////////////////////////////////////////////Buttons
  //Reset the board
  void _newGame() {
    turn = x;
    board[0] = '1';
    board[1] = '2';
    board[2] = '3';
    board[3] = '4';
    board[4] = '5';
    board[5] = '6';
    board[6] = '7';
    board[7] = '8';
    board[8] = '9';
    win = 0;
    print("New Game");
    displayBoard();
    setState(() {
      for (var i = 0; i < board.length; i++) {
        boxInitial[i] = '';
      }
      whosTurn = "Choose a square!";
    });
  }

// This fuction will place a X on the squares that the player selected
// It will also call other functions
  void _button(int square) async {
    setState(() {
      boxInitial[square] = x;
      whosTurn = "It's my turn";
    });
    board[square] = x;
    turn = o;
    print("Its my turn");
    displayBoard();
    win = checkForWinner();
    showStatus();
    await Future.delayed(const Duration(seconds: 3));
    if (win == 0 && turn == o) {
      getComputerMove();
      turn = x;
      setState(() {
        whosTurn = "It's your turn";
      });
      win = checkForWinner();
      displayBoard();
      showStatus();
    }
  }

  /////////////////////////////////////////////////////////Game functionality

  // Display end results of the game to the user
  void showStatus() {
    // Report the winner
    if (win == 1) {
      print("It's a tie.");
      tieCounter++;

      setState(() {
        whosTurn = "It's a tie";
        ties = tieCounter.toString();
      });
    } else if (win == 2) {
      print(x + " wins!");
      humanCounter++;
      whosTurn = "You WON!";

      setState(() {
        whosTurn = "You WON!";
        xWins = humanCounter.toString();
      });
    } else if (win == 3) {
      print(o + " wins!");
      computerCounter++;

      setState(() {
        whosTurn = "I WON!";
        oWins = computerCounter.toString();
      });
    } else {
      print("There is a logic problem! or no one win yet");
    }
  }

  // Show what is going on, on the user interface for debugging purposes
  void displayBoard() {
    print("");
    print(board[0] + " | " + board[1] + " | " + board[2]);
    print("-----------");
    print(board[3] + " | " + board[4] + " | " + board[5]);
    print("-----------");
    print(board[6] + " | " + board[7] + " | " + board[8]);
    print("");
  }

  // Check for a winner.  Return
  //  0 if no winner or tie yet
  //  1 if it's a tie
  //  2 if X won
  //  3 if O won
  int checkForWinner() {
    // Check horizontal wins
    for (var i = 0; i <= 6; i += 3) {
      if (board[i] == x && board[i + 1] == x && board[i + 2] == x) {
        return 2;
      }
      if (board[i] == o && board[i + 1] == o && board[i + 2] == o) {
        return 3;
      }
    }

    // Check vertical wins
    for (var i = 0; i <= 2; i++) {
      if (board[i] == x && board[i + 3] == x && board[i + 6] == x) {
        return 2;
      }
      if (board[i] == o && board[i + 3] == o && board[i + 6] == o) {
        return 3;
      }
    }

    // Check for diagonal wins
    if ((board[0] == x && board[4] == x && board[8] == x) ||
        (board[2] == x && board[4] == x && board[6] == x)) {
      return 2;
    }
    if ((board[0] == o && board[4] == o && board[8] == o) ||
        (board[2] == o && board[4] == o && board[6] == o)) {
      return 3;
    }

    // Check for tie
    for (var i = 0; i < board.length; i++) {
      // If we find a number, then no one has won yet
      if (board[i] != x && board[i] != o) {
        return 0;
      }
    }
    // If we make it through the previous loop, all places are taken, so it's a tie
    return 1;
  }

  // Pick logical move for the computer after user select
  // his/her spot
  void getComputerMove() {
    int move;
    // First see if there's a move O can make to win
    for (var i = 0; i < board.length; i++) {
      if (board[i] != x && board[i] != o) {
        var curr = board[i];
        board[i] = o;
        if (checkForWinner() == 3) {
          setState(() {
            boxInitial[i] = o;
          });
          board[i] = o;
          //print("Computer is moving to"  $(i + 1));
          return;
        } else {
          board[i] = curr;
        }
      }
    }
    // See if there's a move O can make to block X from winning
    for (var i = 0; i < board.length; i++) {
      if (board[i] != x && board[i] != o) {
        var curr = board[i]; // Save the current number
        board[i] = x;
        if (checkForWinner() == 2) {
          setState(() {
            boxInitial[i] = o;
          });
          board[i] = o;
          //print("Computer is moving to " + (i + 1));
          return;
        } else {
          board[i] = curr;
        }
      }
    }
    // Generate random move
    do {
      move = random.nextInt(board.length);
    } while (board[move] == x || board[move] == o);
    setState(() {
      boxInitial[move] = o;
    });
    board[move] = o;
    //print("Computer is moving to " + (move + 1));
  }

////////////////////////////////////////////////////////////////////Body of app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        leading: IconButton(
          ////////////////first label button
          icon: const Icon(
            Icons.border_all,
            semanticLabel: 'menu',
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            ///////////////////// New game
            icon: const Icon(Icons.new_releases),
            onPressed: () {
              _newGame();
            },
            tooltip: "New Game",
          ),
          IconButton(
            /////////////////////////////// Reset score
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _resetScore();
            },
            tooltip: "Quit game",
          ),
          IconButton(
            /////////////////////////////// Close the app
            icon: const Icon(Icons.close),
            onPressed: () => exit(0),
            tooltip: "Quit game",
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                // Pop up menu items
                PopupMenuItem(
                  child: TextButton(
                    ///////////////// About
                    child: const Text(
                      'About',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                  value: 1,
                  onTap: null,
                ),

                const PopupMenuItem(
                    child: Text(
                      "Settings", ////// Settings
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    value: 1,
                    onTap: null)
              ];
            },
          )
        ],
      ), ///////////////////////////////////////// end of app bar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              // First 3 buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[0] == '' && turn == x && win == 0) {
                        _button(0);
                      } //////////////////////button1
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[0],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[1] == '' && turn == x && win == 0) {
                        _button(1);
                      } //////////////////////button2
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[1],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[2] == '' && turn == x && win == 0) {
                        _button(2);
                      } //////////////////////button3
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[2],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square
              ],
            ), /////////////////////////////////////// end of row

            Row(
              // seconf 3 buttond
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[3] == '' && turn == x && win == 0) {
                        _button(3);
                      } //////////////////////button4
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[3],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[4] == '' && turn == x && win == 0) {
                        _button(4);
                      } //////////////////////button5
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[4],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[5] == '' && turn == x && win == 0) {
                        _button(5);
                      } //////////////////////button6
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[5],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square
              ],
            ), /////////////////////////////////// end of second row

            Row(
              // Third 3 buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[6] == '' && turn == x && win == 0) {
                        _button(6);
                      } //////////////////////button7
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[6],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[7] == '' && turn == x && win == 0) {
                        _button(7);
                      } //////////////////////button8
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[7],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square

                Container(
                  height: 100.0,
                  width: 100.0,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (boxInitial[8] == '' && turn == x && win == 0) {
                        _button(8);
                      } //////////////////////button9
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey)),
                    child: Text(
                      boxInitial[8],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                ), // ////////////////////////////end of square
              ],
            ), //////////////////////////// end of third row

            // Text below the squares////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                  width: 300.0,
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    whosTurn,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Roboto'),
                  ),
                )
              ],
            ), ///////////////////////////// End of text row

            //////////////// Score bored
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      "Human:      ",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      "Computer:      ",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      "Ties:      ",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      xWins,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      oWins,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      ties,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'Roboto'),
                    )
                  ],
                )
              ],
            ) // end score board
          ],
        ),
      ),
    );
  }
}
