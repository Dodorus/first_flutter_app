import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TickTackToe(),
    );
  }
}

class TickTackToe extends StatefulWidget {
  @override
  _TickTackToeState createState() => _TickTackToeState();
}

class _TickTackToeState extends State<TickTackToe> {
  GameState game = GameState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  game.reset();
                });
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text(activePlayer)),
          Expanded(
              child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (i) {
              int row = i ~/ 3;
              int column = i % 3;

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        game.move(row, column);
                      });
                    },
                    child: Text(game.field[row][column])),
              );
            }),
          ))
        ],
      ),
    );
  }
}
