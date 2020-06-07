import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/provider_game.dart';
import '../services/const.dart';
import '../widgets/widget_simon_welcome.dart';
import '../widgets/widget_game_play.dart';
import '../widgets/widget_simon_block.dart';
import '../widgets/widget_backdrop.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (BuildContext context, gameProvider, Widget child) {
        if (!gameProvider.isGameStarted) gameProvider.getHighScore();
        if (gameProvider.dartsTurn && !gameProvider.dartsPlaying) {
          gameProvider.playSequences();
        }

        return Container(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _buildRow(ColorBlock.green, ColorBlock.red),
                  _buildRow(ColorBlock.yellow, ColorBlock.blue),
                ],
              ),
              BackDrop(),
              SimonWelcome(),
              PlayButton(),
            ],
          ),
        );
      },
    );
  }

  _buildRow(color1, color2) {
    return Row(
      children: <Widget>[
        _buildBlock(color1),
        _buildBlock(color2),
      ],
    );
  }

  _buildBlock(colorBlocks) {
    return SimonBlock(colorBlocks, false);
  }
}
