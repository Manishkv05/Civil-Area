
import 'package:flutter/material.dart';

class TouchPointPainter extends CustomPainter {
  final List<Offset> touchPoints;


  TouchPointPainter(this.touchPoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
       ..strokeWidth = 3.0
       
      ..style = PaintingStyle.fill;
        // Draw lines between consecutive points
         for (final point in touchPoints) {
      canvas.drawCircle(point, 5, paint);
    }
    for (int i = 0; i < touchPoints.length - 1; i++) {
      
      canvas.drawLine(touchPoints[i], touchPoints[i + 1], paint);
    }

    // Draw circles at each point (optional, for visibility)
    final pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
 for (int i = 0; i < touchPoints.length - 1; i++) 
    {
      final point = touchPoints[i];
      canvas.drawCircle(point, 5, pointPaint);
           final label = String.fromCharCode('a'.codeUnitAt(0) + i); // Generate labels "a", "b", "c", etc.
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
        final textOffset = Offset(point.dx - textPainter.width / 2, point.dy - textPainter.height - 10);
      textPainter.paint(canvas, textOffset);
    }
  }
  // Draw label
 

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
   bool _isCloseToFirstPoint(Offset tapPosition) {
    const double threshold = 10.0; // Define how close is "close enough"
    return (tapPosition - touchPoints.first).distance < threshold;
  }
}
