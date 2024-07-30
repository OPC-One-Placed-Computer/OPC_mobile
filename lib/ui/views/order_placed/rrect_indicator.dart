import 'package:flutter/material.dart';

class RRectIndicator extends Decoration {
  final BoxPainter _painter;

  RRectIndicator(
      {required Color color,
      required double radius,
      required double horizontalPadding,
      required double height})
      : _painter = _RRectPainter(color, radius, horizontalPadding, height);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RRectPainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final double horizontalPadding;
  final double height;

  _RRectPainter(Color color, this.radius, this.horizontalPadding, this.height)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    const double adjustedHorizontalOffset = -60.0;

    final Rect rect = Offset(
            offset.dx - horizontalPadding + adjustedHorizontalOffset,
            offset.dy + configuration.size!.height - height) &
        Size(configuration.size!.width + 2 * horizontalPadding, height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rRect, _paint);
  }
}
