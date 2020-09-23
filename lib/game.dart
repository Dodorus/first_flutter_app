import 'dart:math';

import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  /* In dieser Datenstruktur speichern wir das Feld */
  List<List<String>> field;

  // in dieser Variablen steht, welcher Spieler dran ist
  // Spieler mit Symbol X
  // Spieler mit Symbol O
  String activePlayer;

  // falls jemand gewonnen hat, wird hier der Gewinner gespeichert
  // falls Gewinner nicht feststeht: ''
  // falls unentschieden: 'U'
  String winner;

  int countMoves;

  GameState() {
    reset();
  }

  void reset() {
    field = List.generate(3, (index) => List.generate(3, (index) => ''));

    Random random = new Random();
    activePlayer = random.nextBool() ? 'X' : 'O';
    winner = '';
    countMoves = 0;
    notifyListeners();
  }

  @override
  String toString() {
    // return a string representation of the field for debugging
    return field.join('\n');
  }

  bool canMove(int row, int column) {
    return field[row][column] == '';
  }

  void move(int row, int column) {
    // Wenn das Feld schon besetzt ist, oder der Gewinner shcon fest steht,
    // dann wird diese Funktion abgebrochen
    if (!canMove(row, column) || winner != '') return;

    // Züge mitzählen
    countMoves++;

    // Zug wird in der Tabelle eingetragen
    field[row][column] = activePlayer;

    // Überprüfung, ob aktueller Spieler gewonnen hat
    if (checkWinningMove(row, column)) {
      winner = activePlayer;
    } else {
      if (countMoves == 9) winner = 'U';

      // falls niemand gewonnen hat, dann wechselt der Spieler
      if (winner == '') activePlayer = activePlayer == 'X' ? 'O' : 'X';
    }

    // Beobachter informieren
    notifyListeners();
  }

  bool checkWinningMove(int row, int column) {
    for (int i = 0; i < 3; i++) {
      if (field[i][0] == activePlayer &&
          field[i][1] == activePlayer &&
          field[i][2] == activePlayer) return true;

      if (field[0][i] == activePlayer &&
          field[1][i] == activePlayer &&
          field[2][i] == activePlayer) return true;
    }

    if (field[0][0] == activePlayer &&
        field[1][1] == activePlayer &&
        field[2][2] == activePlayer) return true;

    if (field[2][0] == activePlayer &&
        field[1][1] == activePlayer &&
        field[0][2] == activePlayer) return true;

    return false;
  }
}
