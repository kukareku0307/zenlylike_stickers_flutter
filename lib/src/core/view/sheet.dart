import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/core/view/components/inherited_index.dart';
import 'package:send_stickers_example/src/core/view/components/page_indicator.dart';
import 'package:send_stickers_example/src/core/view/sticker_table.dart';
import 'package:send_stickers_example/src/settings/settings_stickers.dart';

class SheetWidget extends StatefulWidget {
  const SheetWidget({
    super.key,
  });

  @override
  State<SheetWidget> createState() => _SheetWidgetState();
}

class _SheetWidgetState extends State<SheetWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color oppositeBackground =
        !isDarkMode ? Colors.white70 : Colors.black87;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: oppositeBackground),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spacer(),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: PageView(
                  clipBehavior: Clip.none,
                  onPageChanged: (value) => setState(() {
                    _currentPage = value;
                  }),
                  children: List.generate(
                      (StickersSettings.stickersMap.length / 8).ceil(),
                      (index) {
                    return PageIndexInherited(
                      currentPageIndex: index,
                      child: const StickerTable());
                  }),
                ),
              ),
              PageIndicatorWidget(currentPage: _currentPage),
            ],
          ),
        );
      },
    );
  }
}
