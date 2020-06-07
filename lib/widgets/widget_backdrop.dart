import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider_game.dart';

import '../services/const.dart';

class BackDrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (Provider.of<GameProvider>(context).isGameStarted) ? 0 : 1,
      duration: fadeOutDuration,
      child: Visibility(
        visible: !(Provider.of<GameProvider>(context).isGameStarted),
        child: Container(
          width: double.infinity,
          color: mainBackDrop,
        ),
      ),
    );
  }
}
