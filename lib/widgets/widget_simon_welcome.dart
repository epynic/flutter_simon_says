import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider_game.dart';
import '../services/const.dart';

class SimonWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (Provider.of<GameProvider>(context).isGameStarted) ? 0 : 1,
      duration: fadeOutDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .20,
          ),
          child: Text(
            'SIMON SAYS',
            style: TextStyle(
              color: mainSimonText,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
