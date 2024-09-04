import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  final List<List<Offset>> diagonals;

  DiagonalPainter(this.diagonals);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // Draw all diagonals
    for (var pair in diagonals) {
    
        canvas.drawLine(pair[0], pair[1], paint);
      
    }

    // Optional: Draw circles at each point for visibility
    final pointPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    for (var pair in diagonals) {
      if (pair.length <=2) {
        canvas.drawCircle(pair[0], 5, pointPaint);
        canvas.drawCircle(pair[1], 5, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}