import 'package:flutter/cupertino.dart';

class CupertinoButtonWidget extends StatelessWidget {
  const CupertinoButtonWidget(
      {super.key, required this.child, this.onPressed, this.color});
  final Color? color;
  final Widget child;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        minSize: 0,
        color: color,
        padding: EdgeInsets.zero,
        child: child);
  }
}