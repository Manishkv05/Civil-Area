import 'dart:math';

double calculateTriangleAreaFromSides(double a, double b, double c) {
  // Calculate the semi-perimeter
  double s = (a + b + c) / 2;
  
  // Calculate the area using Heron's formula
  return sqrt(s * (s - a) * (s - b) * (s - c));
}

double calculatePolygonAreaFromSides(List<List<double?>> triangleSides) {
  double totalArea = 0.0;
 if(triangleSides!=null){
  // Iterate over each triangle and calculate its area
  for (List<double?> sides in triangleSides) {
    if (sides.length == 3) {
      double a = sides[0]??0.0;
      double b = sides[1]??0.0;
      double c = sides[2]??0.0;

      double area = calculateTriangleAreaFromSides(a, b, c);
      totalArea += area;
    } else {
      throw Exception('Each triangle must have exactly 3 sides.');
    }
  }
 }

  return totalArea;
}

// void main() {
//   // Example: A quadrilateral divided into two triangles
//   // Triangle 1 sides: 3, 4, 5 (a right triangle)
//   // Triangle 2 sides: 3, 4, 5 (another right triangle)
//   List<List<double>> triangleSides = [
//     [3, 4, 5],
//     [3, 4, 5]
//   ];

//   double area = calculatePolygonAreaFromSides(triangleSides);
//   print('Total Area of the Polygon: $area');
// }
