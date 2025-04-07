import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/core/view/components/inherited_index.dart';
import 'package:send_stickers_example/src/settings/settings_stickers.dart';

class StickerPhotoWidget extends StatelessWidget {
  const StickerPhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final pageIndex =
          PageIndexInherited.of(context)?.currentPageIndex ?? 0;
      final tableIndex =
          TableIndexInherited.of(context)?.currentTableIndex ?? 0;
      return StickersSettings
                  .stickersMap[tableIndex + (8 * pageIndex)] !=
              null
          ? LayoutBuilder(builder: (context, sizes) {
            String name = StickersSettings
                .stickersMap[tableIndex + (8 * pageIndex)]!.name;
            return Image.asset(
              "assets/stickers/$name.png",
              fit: BoxFit.contain,
              cacheWidth: (sizes.maxWidth *
                      MediaQuery.of(context).devicePixelRatio)
                  .round(),
              frameBuilder: (context, child, frame,
                  wasSynchronouslyLoaded) {
                if (!wasSynchronouslyLoaded) {
                  return AnimatedOpacity(
                    opacity: frame != null
                        ? 1.0
                        : 0.0, // Прозрачность зависит от загрузки кадра
                    duration: const Duration(milliseconds: 250),
                    child: child,
                  );
                } else {
                  return child;
                }
              },
            );
          })
          : SizedBox();
    });
  }
}
