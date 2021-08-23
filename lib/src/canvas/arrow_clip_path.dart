import 'package:flutter/cupertino.dart';

enum ArrowDirection {
  UP,
  MIDDLE,
  DOWN,
}

class ArrowClipPath extends CustomClipper<Path> {
  ArrowDirection direction;
  ArrowClipPath({required this.direction});

  @override
  Path getClip(Size size) {
    switch (direction) {
      case ArrowDirection.UP:
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width * 0.5, 0)
          ..lineTo(size.width, size.height)
          ..close();
      case ArrowDirection.MIDDLE:
        return Path()
          ..moveTo(0, size.height * 0.45)
          ..lineTo(size.width * 0.6, size.height * 0.45)
          ..lineTo(size.width * 0.6, size.height * 0.55)
          ..lineTo(0, size.height * 0.55)
          ..close();
      case ArrowDirection.DOWN:
        return Path()
          ..moveTo(0, 0)
          ..lineTo(size.width * 0.5, size.height)
          ..lineTo(size.width, 0)
          ..close();
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
