import 'dart:math';

import 'package:flutter/material.dart';

import '../common.dart';

const double _triangleRatio = 0.9;

enum ArrowSide { top, bottom, left, right }

class BoundingContainerWithArrows extends StatelessWidget {
  final double offsetPercentage;
  final PickerSize pickerSize;
  final ArrowSide arrowSide;

  const BoundingContainerWithArrows({
    Key key,
    @required this.offsetPercentage,
    @required this.pickerSize,
    @required this.arrowSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.dependOnInheritedWidgetOfExactType<ColorInheritedWidget>();
    return Container(
      child: CustomPaint(
          size: Size(pickerSize.pickerWidth, pickerSize.totalBoundedHeight),
          painter: DrawTriangle(
            percentage: offsetPercentage,
            pickerSize: pickerSize,
            arrowSide: arrowSide,
            arrowColor: colors.pickerBodyColors.color(context),
          )),
    );
  }
}

class DrawTriangle extends CustomPainter {
  final double percentage;
  final PickerSize pickerSize;
  final ArrowSide arrowSide;
  final Color arrowColor;
  Paint _paint;

  DrawTriangle({
    @required this.percentage,
    @required this.pickerSize,
    @required this.arrowSide,
    @required this.arrowColor,
  }) {
    _paint = Paint()
      ..color = arrowColor
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (arrowSide) {
      case ArrowSide.bottom:
        return canvas.drawPath(_bottomArrow(size.width, size.height, percentage), _paint);
      case ArrowSide.left:
        return canvas.drawPath(_leftArrow(size.height, percentage), _paint);
      case ArrowSide.right:
        return canvas.drawPath(_rightArrow(size.height, size.width, 1.0), _paint);
      case ArrowSide.top:
        return canvas.drawPath(_topArrow(size.width, percentage), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path _topArrow(double width, double percentage) {
    var path = Path();
    double startX = max(pickerSize.triangleHeight, (width * percentage) - (pickerSize.triangleHeight / _triangleRatio));
    double midX = startX + (pickerSize.triangleHeight / _triangleRatio);
    double finishX = midX + (pickerSize.triangleHeight / _triangleRatio);
    if (finishX > width - pickerSize.triangleHeight) return _topArrow(width, percentage - 0.01);
    path.moveTo(startX, pickerSize.triangleHeight);
    path.lineTo(midX, 0);
    path.lineTo(finishX, pickerSize.triangleHeight);
    path.close();
    return path;
  }

  Path _bottomArrow(double width, double height, double percentage) {
    var path = Path();
    double startX = max(pickerSize.triangleHeight, (width * percentage) - (pickerSize.triangleHeight / _triangleRatio));
    double midX = startX + (pickerSize.triangleHeight / _triangleRatio);
    double finishX = midX + (pickerSize.triangleHeight / _triangleRatio);
    if (finishX > width - pickerSize.triangleHeight) return _bottomArrow(width, height, percentage - 0.01);
    path.moveTo(startX, height - pickerSize.triangleHeight - pickerSize.arrowPointAdjustment);
    path.lineTo(midX, height);
    path.lineTo(finishX, height - pickerSize.triangleHeight - pickerSize.arrowPointAdjustment);
    path.close();
    return path;
  }

  Path _leftArrow(double height, double percentage) {
    var path = Path();
    double startY =
        max(pickerSize.triangleHeight, (height * percentage) - (pickerSize.triangleHeight / _triangleRatio));
    double midY = startY + (pickerSize.triangleHeight / _triangleRatio);
    double finishY = midY + (pickerSize.triangleHeight / _triangleRatio);
    if (finishY > height - pickerSize.triangleHeight) return _leftArrow(height, percentage - 0.01);
    path.moveTo(pickerSize.triangleHeight, startY);
    path.lineTo(0, midY);
    path.lineTo(pickerSize.triangleHeight, finishY);
    path.close();
    return path;
  }

  Path _rightArrow(double height, double width, double percentage) {
    var path = Path();
    double startY =
        max(pickerSize.triangleHeight, (height * percentage) - (pickerSize.triangleHeight / _triangleRatio));
    double midY = startY + (pickerSize.triangleHeight / _triangleRatio);
    double finishY = midY + (pickerSize.triangleHeight / _triangleRatio);
    if (finishY > height - pickerSize.triangleHeight) return _rightArrow(height, width, percentage - 0.01);
    path.moveTo(width - ((pickerSize.triangleHeight / _triangleRatio)), startY);
    path.lineTo(width, midY);
    path.lineTo(width - ((pickerSize.triangleHeight / _triangleRatio)), finishY);
    path.close();
    return path;
  }
}
