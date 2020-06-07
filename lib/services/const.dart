import 'package:flutter/material.dart';
import '../model/simon_color_model.dart';

final String gameTitle = "Simon Says";
enum ColorBlock { red, green, yellow, blue }

final Color mainGameColors = Colors.black;
final Color mainBackDrop = Colors.black45;
final Color mainSimonText = Colors.orangeAccent;
final Color mainPlayButtonColor = Colors.white;
final Color mainPlayIconColor = Colors.black;

final Duration fadeOutDuration = Duration(milliseconds: 500);
final Duration simonBlockAnimationDuration = Duration(milliseconds: 80);

final double simonBlockDefaultPadding = 10;
final double simonBlockClickPadding = 20;


final Map<ColorBlock, SimonColor> gameColors = {
  ColorBlock.blue: SimonColor(
      primary: Colors.blue, soundFile: 'blue_ting.mp3', isSelected: false),
  ColorBlock.green: SimonColor(
      primary: Colors.green, soundFile: 'green_ting.mp3', isSelected: false),
  ColorBlock.yellow: SimonColor(
      primary: Colors.yellow, soundFile: 'yellow_ting.mp3', isSelected: false),
  ColorBlock.red: SimonColor(
      primary: Colors.red, soundFile: 'red_ting.mp3', isSelected: false),
};
