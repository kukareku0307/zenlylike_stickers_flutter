import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/settings/settings_stickers.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (StickersSettings.stickersMap.length / 8).ceil(),
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 18.5),
              height: 9,
              width: 9,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode
                      ? (index == currentPage
                          ? const Color.fromRGBO(217, 217, 217, 1)
                          : const Color.fromRGBO(61, 61, 61, 1))
                      : (index == currentPage
                          ? const Color.fromRGBO(61, 61, 61, 1)
                          : const Color.fromRGBO(161, 161, 161, 1))),
            ),
          ),
        ),
      ),
    );
  }
}
