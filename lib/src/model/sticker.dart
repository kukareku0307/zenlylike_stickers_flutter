import 'package:flutter/material.dart';

class Sticker {
  final String name;
  final List<Widget> animatedStickers;
  
  Sticker(this.name, [List<Widget>? animatedStickers]) 
      : animatedStickers = animatedStickers ?? []; // Изменяемый список
}
