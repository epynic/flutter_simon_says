import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimonSays',
      home: MemoryChamp(),
    );
  }
}

class MemoryChamp extends StatefulWidget {
  @override
  _MemoryChampState createState() => _MemoryChampState();
}

class _MemoryChampState extends State<MemoryChamp> {
  var computersTurn = true;
  var gameOver = true;

  var randomPicker = Random();
  List allowedStack = ['red', 'green', 'blue', 'yellow'];

  List memoryStack = [];
  var curSel = '';
  var playerSelIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  computerPlays() {
    setState(() {
      gameOver = false;
    });

    var newPick = allowedStack[randomPicker.nextInt(allowedStack.length)];
    memoryStack.add(newPick);
    var idx = 1;
    var idxDelay = 1;
    memoryStack.forEach((data) {
      Future.delayed(Duration(seconds: 2 * idx), () {
        setState(() {
          curSel = data;
        });
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            curSel = '';
            if (memoryStack.length == idxDelay) {
              computersTurn = false;
              playerSelIdx = 0;
            }
          });
          idxDelay++;
        });
      });
      idx++;
    });
  }

  playerPlays(sel) {
    if (computersTurn) return false;

    if (memoryStack[playerSelIdx] == sel) {
      if (memoryStack.length - 1 == playerSelIdx) {
        setState(() {
          computersTurn = true;
        });
        computerPlays();
      } else {
        setState(() {
          curSel = 'Next';
        });
      }
      playerSelIdx++;
    } else {
      setState(() {
        gameOver = true;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('Your Scored:  ${playerSelIdx}'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Reset'),
                  onPressed: () => resetPlay(),
                )
              ],
            );
          });
    }
  }

  resetPlay() {
    setState(() {
      playerSelIdx = 0;
      memoryStack = [];
      computersTurn = true;
      curSel = '';
      gameOver = true;
    });
    Navigator.of(context).pop();
  }

  Widget colorBlocks({curSel, selCur, pickColor, pickText}) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: pickColor,
          boxShadow: [
            BoxShadow(
              color: pickColor,
              blurRadius: (curSel == selCur) ? 20 : 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: () => playerPlays(selCur),
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              child: Center(
                child: Text(
                  pickText,
                  style: TextStyle(fontSize: (curSel == selCur) ? 40 : 15),
                ),
              ),
              height: (MediaQuery.of(context).size.height - 30) / 2,
              width: (MediaQuery.of(context).size.width - 30) / 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  colorBlocks(
                    curSel: curSel,
                    selCur: 'red',
                    pickColor: Colors.red,
                    pickText: 'Red',
                  ),
                  colorBlocks(
                    curSel: curSel,
                    selCur: 'yellow',
                    pickColor: Colors.yellow,
                    pickText: 'Yellow',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  colorBlocks(
                    curSel: curSel,
                    selCur: 'green',
                    pickColor: Colors.green,
                    pickText: 'Green',
                  ),
                  colorBlocks(
                    curSel: curSel,
                    selCur: 'blue',
                    pickColor: Colors.blue,
                    pickText: 'Blue',
                  ),
                ],
              )
            ],
          ),
          Positioned(
            child: Text(
              curSel,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: 20,
            right: 40,
          ),
          Positioned(
            bottom: 10,
            right: 40,
            child: (computersTurn)
                ? Text(
                    'com plays',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    'Your turn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          (gameOver)
              ? Positioned(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.blueGrey,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(150),
                        onTap: () => computerPlays(),
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  top: (MediaQuery.of(context).size.height - 150) / 2,
                  left: (MediaQuery.of(context).size.width - 150) / 2,
                )
              : Container()
        ],
      ),
    );
  }
}
