
// import 'dart:ui';

// import 'package:flutter/material.dart';

// List<List<double>> calculateTriangleSides(
//     List<Offset> points,
//     List<List<Offset>> diagonals,
//     List<String> edgeLengths,
//     List<String> diagonalLengths,
//     List<Offset> midpoint,
//     List<Offset> dmidpoints,
    
//     ) {
  
//   List<List<double>> triangles = [];




//   // Helper to calculate distance between two points
//   double distance(Offset p1, Offset p2) {
    
//       Offset mpoint = Offset(
//         (p1.dx + p2.dx) / 2,
//         (p1.dy + p2.dy) / 2,
//       );
//       for(int i=0;i<midpoint.length;i++)
//       {
//        if(midpoint.contains(mpoint))
//        {
//         var i=midpoint.indexOf(mpoint);
//         return double.parse(edgeLengths[i]);

//        }else if(dmidpoints.contains(mpoint)){
//           var i=dmidpoints.indexOf(mpoint);
//         return double.parse(diagonalLengths[i]);
//        }
      
//       }
           

//      return 0.0;
//   }

//   // For each pair of diagonals, create triangles
//   for (List<Offset> diagonal in diagonals) {
//     Offset d1 = diagonal[0];
//     Offset d2 = diagonal[1];

//     // Find edge lengths
//     List<double> edges = [
//       distance(d1, points[0]),
//       distance(d2, points[0]),
//       distance(d1, d2)
//     ];

//     triangles.add(edges);
//   }

//   // Ensure that triangles are unique (avoid repetition)
//   List<List<double>> uniqueTriangles = [];
//   for (List<double> tri in triangles) {
   
//       // for(var p in tri)
//       // {
//       //   if()
//       // }
//        uniqueTriangles.add(tri);
    
//   }

//   return uniqueTriangles;
// }

import 'dart:ui';
import 'package:flutter/material.dart';

List<List<double>> calculateTriangleSides(
    List<Offset> points,
    List<List<Offset>> diagonals,
    List<String> edgeLengths,
    List<String> diagonalLengths,
    List<Offset> midpoint,
    List<Offset> dmidpoints) {
  List<List<double>> triangles = [];

  // Helper to calculate distance between two points
  double distance(Offset p1, Offset p2) {
    Offset mpoint = Offset(
      (p1.dx + p2.dx) / 2,
      (p1.dy + p2.dy) / 2,
    );

    if (midpoint.contains(mpoint)) {
      var i = midpoint.indexOf(mpoint);
      return double.parse(edgeLengths[i]);
    } else if (dmidpoints.contains(mpoint)) {
      var i = dmidpoints.indexOf(mpoint);
      return double.parse(diagonalLengths[i]);
    }

    // If the midpoint doesn't match, we assume this isn't a valid edge/diagonal
    return 0.0;
  }

  // For each diagonal, try to form triangles with the remaining points
  for (List<Offset> diagonal in diagonals) {
    Offset d1 = diagonal[0];
    Offset d2 = diagonal[1];

    for (Offset point in points) {
      if (point == d1 || point == d2) continue; // Skip if the point is part of the diagonal

      // Calculate the sides of the potential triangle
      double side1 = distance(d1, point);
      double side2 = distance(d2, point);
      double side3 = distance(d1, d2);

      // Check if all sides are valid (non-zero)
      if (side1 > 0 && side2 > 0 && side3 > 0) {
        List<double> edges = [side1, side2, side3];
        edges.sort(); // Sort to maintain consistency

        // Ensure uniqueness by checking if this triangle already exists
        if (!triangles.any((tri) =>
            tri[0] == edges[0] && tri[1] == edges[1] && tri[2] == edges[2])) {
          triangles.add(edges);
        }
      }
    }
  }

  return triangles;
}
