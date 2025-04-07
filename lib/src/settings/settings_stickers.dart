import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/model/sticker.dart';

///singleton class to share stickers settings
class StickersSettings {
  static Map<int, Sticker> stickersMap = {
    0: Sticker("wow", []),
    1: Sticker("fire", []),
    2: Sticker("sos", []),
    3: Sticker("love", []),
    4: Sticker("mew", []),
    5: Sticker("rock", []),
    6: Sticker("prog", []),
    7: Sticker("pet", []),
    8: Sticker("cool", []),
    9: Sticker("kiss", []),
    10: Sticker("lucky", []),
    11: Sticker("angry", []),
    12: Sticker("hmm", []),
    13: Sticker("peach", []),
    14: Sticker("music", []),
    15: Sticker("fight", []),
    16: Sticker("gym", []),
    17: Sticker("wow", []),
    18: Sticker("burger", []),
  };
  static const int animationMilliseconds = 510;
  static Offset stickerDestination = Offset(0, 0);
}
