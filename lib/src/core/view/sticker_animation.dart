import 'package:flutter/material.dart';
import 'package:send_stickers_example/src/core/view/components/sticker_photo_widget.dart';
import 'package:send_stickers_example/src/settings/settings_stickers.dart';

///Widget that animates offset + opacity
class StickerAnimationWidget extends StatefulWidget {
  const StickerAnimationWidget({Key? key}) : super(key: key);

  @override
  State<StickerAnimationWidget> createState() => _StickerAnimationWidgetState();
}

class _StickerAnimationWidgetState extends State<StickerAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: StickersSettings.animationMilliseconds),
      vsync: this,
    );

    _fadeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 1)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 70.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 0.5)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30.0,
        ),
      ],
    ).animate(_controller);

    _sizeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1, end: 2)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem(tween: ConstantTween(2), weight: 20),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 2, end: 0.8)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 30.0,
        ),
      ],
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      key: _widgetKey,
      opacity: _fadeAnimation,
      child: LayoutBuilder(
        builder: (context, sizes) {

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final RenderBox? renderBox =
                  _widgetKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox == null) return SizedBox(); // Заглушка на первый кадр
          
              final widgetPosition = renderBox.localToGlobal(Offset.zero);
              final center = StickersSettings.stickerDestination;
          
              final offset = Offset(
                center.dx - widgetPosition.dx - (sizes.maxWidth / 2),
                center.dy - widgetPosition.dy - (sizes.maxWidth / 2),
              );
          
              return Transform.translate(
                offset: offset * _controller.value,
                child: Transform.scale(
                  scale: _sizeAnimation.value,
                  child: const StickerPhotoWidget()
                ),
              );
            },
          );
        }
      ),
    );
  }
}