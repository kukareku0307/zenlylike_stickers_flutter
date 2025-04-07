import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:send_stickers_example/src/core/view/components/sticker_photo_widget.dart';
import 'package:send_stickers_example/src/core/view/sticker_animation.dart';
import 'package:send_stickers_example/src/settings/settings_stickers.dart';
import 'components/inherited_index.dart';

class StickerTable extends StatefulWidget {
  const StickerTable({
    super.key,
  });

  @override
  State<StickerTable> createState() => _StickerTableState();
}

///Logic to recognise gesture
class _StickerTableState extends State<StickerTable> {
  late final LongPressGestureRecognizer longPressRecognizer;
  late final int pageIndex;
  Timer? timer;
  @override
  void initState() {
    longPressRecognizer = LongPressGestureRecognizer(
        duration: const Duration(
            milliseconds: 250) // Time to recognise gesture to send (not to swipe page) 
        )
      ..onLongPressDown = (details) {
        calculatePart(details.localPosition);
        startSendingStickers();
      }
      ..onLongPressMoveUpdate = (details) {
        calculatePart(details.localPosition);
      }
      ..onLongPressCancel = () {
        stopSendingStickers();
      }
      ..onLongPressEnd = (details) {
        stopSendingStickers();
      };
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageIndex = PageIndexInherited.of(context)?.currentPageIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxHeight = constraints.maxHeight;
      return Listener(
        onPointerDown: (event) {
          longPressRecognizer.addPointer(event);
        },
        child: GestureDetector(
          onTapDown: (event) {
            calculatePart(event.localPosition);
            sendSticker();
          },
          child: Table(children: [
            TableRow(
              children: List.generate(
                4,
                (index) => Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight / 2,
                      child: TableIndexInherited(
                        currentTableIndex: index,
                        child: const StickerPhotoWidget(),
                      ),
                    ),
                    ...?StickersSettings
                        .stickersMap[index + (8 * pageIndex)]?.animatedStickers
                  ],
                ),
              ),
            ),
            TableRow(
              children: List.generate(
                4,
                (index) => Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight / 2,
                      child: TableIndexInherited(
                        currentTableIndex: index + 4,
                        child: const StickerPhotoWidget(),
                      ),
                    ),
                    ...?StickersSettings
                        .stickersMap[(index + 4) + (8 * pageIndex)]
                        ?.animatedStickers
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }

  late double maxHeight;
  int stickerNow = 0;

  void calculatePart(Offset localPosition) {
    int rows = 2;
    int columns = 4;
    double partWidth = MediaQuery.of(context).size.width / columns;
    double partHeight = maxHeight / rows;
    int row = (localPosition.dy ~/ partHeight).clamp(0, rows - 1);
    int column = (localPosition.dx ~/ partWidth).clamp(0, columns - 1);
    int result = (row * columns + column + 1) + 8 * (pageIndex) - 1;
    stickerNow = result;
  }

  void sendSticker() {
    int numNow = stickerNow;
    var uniqueKey = UniqueKey();
    final sticker = TableIndexInherited(
      key: uniqueKey,
      currentTableIndex: stickerNow % 8,
      child: const StickerAnimationWidget(),
    );
    HapticFeedback.mediumImpact();
    StickersSettings.stickersMap[numNow]?.animatedStickers.add(sticker);
    Future<void>.delayed(
            Duration(milliseconds: StickersSettings.animationMilliseconds))
        .then((_) {
      removeSticker(numNow, uniqueKey);
    });
    setState(() {});
  }

  void removeSticker(int numNow, UniqueKey uniqueKey) {
    StickersSettings.stickersMap[numNow]?.animatedStickers
        .removeWhere((Widget w) => w.key == uniqueKey);
    setState(() {});
  }

  void stopSendingStickers() {
    timer?.cancel();
  }

  void startSendingStickers() {
    timer = Timer.periodic(const Duration(milliseconds: 155), (Timer t) async {
      sendSticker();
    });
  }
}
