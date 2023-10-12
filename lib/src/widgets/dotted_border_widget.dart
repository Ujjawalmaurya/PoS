import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MyDottedBorderWidget extends StatelessWidget {
  const MyDottedBorderWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      // child: const ClipRRect(
      // borderRadius: BorderRadius.all(Radius.circular(120)),
      borderType: BorderType.RRect,
      dashPattern: const [8, 3],
      strokeCap: StrokeCap.round,
      child: child,
    );
  }
}
