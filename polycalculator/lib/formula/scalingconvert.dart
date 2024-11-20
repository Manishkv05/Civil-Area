// import 'dart:math';
// import 'package:flutter/material.dart';

// // Helper function to calculate distance between two points
// double distanceBetweenPoints(Offset p1, Offset p2) {
//   return sqrt(pow(p2.dx - p1.dx, 2) + pow(p2.dy - p1.dy, 2));
// }

// // Function to rescale the polygon based on the user's input of edge lengths
// List<Offset> rescalePolygonToCm(List<Offset> originalPoints, List<String> edgeLengthList, double pixelsPerCm) {
//   List<Offset> newPoints = [];

//   // Conversion factor: 1 unit = 0.0635 cm
//   double cmPerUnit = 1.27 / 20;

//   // Ensure the number of provided edge lengths matches the number of edges
//   if (edgeLengthList.length != originalPoints.length-1) {
//     throw Exception("Edge length list does not match the number of edges in the polygon.");
//   }

//   // Add the first point without modification
//   newPoints.add(originalPoints[0]);

//   // Iterate over the edges to rescale the lengths
//   for (int i = 0; i < originalPoints.length-1; i++) {
//     Offset currentPoint = newPoints[i];
//     Offset nextOriginalPoint = originalPoints[i + 1];

//     // Get the user's provided edge length and convert it to double
//     double originalLength = double.parse(edgeLengthList[i]);

//     // Convert the original length from units to centimeters
//     double lengthInCm = originalLength * cmPerUnit;

//     // Convert from centimeters to pixels
//     double lengthInPixels = lengthInCm * pixelsPerCm;

//     // Calculate the direction (angle) of the edge
//     double angle = atan2(nextOriginalPoint.dy - currentPoint.dy, nextOriginalPoint.dx - currentPoint.dx);

//     // Compute the new position based on the direction and the new length in pixels
//     double newX = currentPoint.dx + lengthInPixels * cos(angle);
//     double newY = currentPoint.dy + lengthInPixels * sin(angle);

//     // Add the new point to the list
//     newPoints.add(Offset(newX, newY));
//   }

//   return newPoints;
// }
import 'dart:math';
import 'package:flutter/material.dart';

// Helper function to calculate distance between two points
double distanceBetweenPoints(Offset p1, Offset p2) {
  return sqrt(pow(p2.dx - p1.dx, 2) + pow(p2.dy - p1.dy, 2));
}

// Function to rescale the polygon based on the user's input of edge lengths
List<Offset> rescalePolygonToCm(List<Offset> originalPoints, List<String> edgeLengthList, double pixelsPerCm) {
  List<Offset> newPoints = [];

  // Conversion factor: 1 unit = 0.0635 cm
  double cmPerUnit = 1.27 / 20;

  // Ensure the number of provided edge lengths matches the number of edges
  if (edgeLengthList.length != originalPoints.length - 1) {
    throw Exception("Edge length list does not match the number of edges in the polygon.");
  }

  // Add the first point without modification
  newPoints.add(originalPoints[0]);

  // Iterate over the edges to rescale the lengths
  for (int i = 0; i < originalPoints.length - 1; i++) {
    Offset currentPoint = newPoints[i];
    Offset nextOriginalPoint = originalPoints[i + 1];

    // Get the user's provided edge length and convert it to double
    double originalLength = double.parse(edgeLengthList[i]);

    // Convert the original length from units to centimeters
    double lengthInCm = originalLength * cmPerUnit;

    // Convert from centimeters to pixels
    double lengthInPixels = lengthInCm * pixelsPerCm;

    // Calculate the direction (angle) of the edge
    double angle = atan2(nextOriginalPoint.dy - currentPoint.dy, nextOriginalPoint.dx - currentPoint.dx);

    // Compute the new position based on the direction and the new length in pixels
    double newX = currentPoint.dx + lengthInPixels * cos(angle);
    double newY = currentPoint.dy + lengthInPixels * sin(angle);

    // Add the new point to the list
    newPoints.add(Offset(newX, newY));
  }

  // Replace the first point with the last calculated point
  newPoints[0] = newPoints.last;

  return newPoints;
}
