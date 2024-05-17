//Third Party Imports
import 'package:flutter/material.dart';

class BoxIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BoxPainter();
  }
}

class _BoxPainter extends BoxPainter {
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final Rect rect = offset & configuration.size!;
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Add radius to the rect
    RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(15),
    );
    canvas.drawRRect(roundedRect, paint);

    final Paint strokePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRRect(roundedRect, strokePaint);
  }
}
