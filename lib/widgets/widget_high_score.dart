import 'package:flutter/material.dart';
import 'package:memory_game/services/provider_game.dart';
import 'package:provider/provider.dart';

import '../services/const.dart';

class HighScore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<GameProvider>(context, listen: false).getPlayerHighScore);
    return AnimatedOpacity(
      opacity: (Provider.of<GameProvider>(context).isGameStarted ||
              Provider.of<GameProvider>(context, listen: false)
                      .getPlayerHighScore ==
                  null)
          ? 0
          : 1,
      duration: fadeOutDuration,
      child: Provider.of<GameProvider>(context, listen: false)
                  .getPlayerHighScore !=
              null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Provider.of<GameProvider>(context).isGameOver
                      ? Text(
                          'Last Score: ' +
                              Provider.of<GameProvider>(context)
                                  .getScore
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        )
                      : SizedBox(),
                  SizedBox(height: 5),
                  Text(
                    'HIGH SCORE: ' +
                        Provider.of<GameProvider>(context, listen: false)
                            .getPlayerHighScore
                            .toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          : SizedBox(height: 10),
    );
  }
}
