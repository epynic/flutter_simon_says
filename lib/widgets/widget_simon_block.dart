import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/provider_game.dart';
import '../model/simon_color_model.dart';
import '../services/const.dart';

class SimonBlock extends StatefulWidget {
  final ColorBlock blockColor;
  final bool curSelect;
  final SimonColor simonColor;

  SimonBlock(this.blockColor, this.curSelect)
      : simonColor = gameColors[blockColor];

  @override
  _SimonBlockState createState() => _SimonBlockState();
}

class _SimonBlockState extends State<SimonBlock> {
  bool isClicked = false;
  double paddingValue = 10;

  _blockClicked(ColorBlock clickColor) {
    setState(() {
      paddingValue = simonBlockDefaultPadding;
    });

    Provider.of<GameProvider>(context, listen: false).simonClick(clickColor);
  }

  _blockTapDown() {
    setState(() {
      paddingValue = simonBlockClickPadding;
    });
  }

  @override
  void didChangeDependencies() {
    ColorBlock curBlock = Provider.of<GameProvider>(context).currentSelBlock;
    if (curBlock == widget.blockColor)
      paddingValue = simonBlockClickPadding;
    else
      paddingValue = simonBlockDefaultPadding;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _blockTapDown(),
        onTap: () => _blockClicked(widget.blockColor),
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: AnimatedPadding(
            duration: simonBlockAnimationDuration,
            padding: EdgeInsets.all(paddingValue),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.simonColor.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
