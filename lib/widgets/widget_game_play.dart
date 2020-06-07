import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider_game.dart';
import '../services/const.dart';
import '../widgets/widget_high_score.dart';

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            RaisedButton(
              padding: EdgeInsets.all(25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              onPressed: () =>
                  Provider.of<GameProvider>(context, listen: false).startGame(),
              child: Container(
                height: 80,
                width: 80,
                child: (Provider.of<GameProvider>(context).isGameStarted)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Provider.of<GameProvider>(context, listen: false)
                                  .currentPlayIndex
                                  .toString(),
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              Provider.of<GameProvider>(context, listen: false)
                                  .currentPlayerIndex
                                  .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 80,
                        color: mainPlayIconColor,
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            HighScore()
          ],
        ),
      ),
    );
  }
}
