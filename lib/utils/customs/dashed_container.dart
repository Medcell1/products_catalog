import 'package:flutter/material.dart';

class DashedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Widget? child;

  const DashedContainer({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRectanglePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class _DashedRectanglePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedRectanglePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final dashPattern = [dashWidth, dashSpace];

    _drawDashedLine(canvas, paint, Offset.zero, Offset(size.width, 0), dashPattern);
    _drawDashedLine(canvas, paint, Offset(size.width, 0), Offset(size.width, size.height), dashPattern);
    _drawDashedLine(canvas, paint, Offset(size.width, size.height), Offset(0, size.height), dashPattern);
    _drawDashedLine(canvas, paint, Offset(0, size.height), Offset.zero, dashPattern);
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end, List<double> dashPattern) {
    final path = Path()

      ..moveTo(start.dx, start.dy);

    final dash = dashPattern[0];
    final space = dashPattern[1];
    final vector = end - start;
    final distance = vector.distance;
    final unitVector = vector / distance;

    double drawn = 0.0;
    bool isDash = true;

    while (drawn < distance) {
      final length = isDash ? dash : space;
      final remaining = distance - drawn;
      final toDraw = remaining < length ? remaining : length;

      final endPoint = start + unitVector * (drawn + toDraw);
      if (isDash) {
        path.lineTo(endPoint.dx, endPoint.dy);
      } else {
        path.moveTo(endPoint.dx, endPoint.dy);
      }

      drawn += toDraw;
      isDash = !isDash;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}