import 'dart:collection';
import 'dart:ui';

List<List<Offset?>> initializeEmptyList(List<List<Offset>> triangles) {
  return List.generate(
    triangles.length,
    (_) => List.filled(triangles[0].length, null), // Assuming all triangles have the same length
  );
}

void updateListWithEdgeOrDiagonalLengths(
  List<List<Offset>> triangles,
  List<List<Offset>> midpointlist,
  List<List<Offset>> diamidpoint,
  List<String> edgelengthlist,
  List<String> diagonallengthlist,
  List<List<Offset?>> emptyList,
) {
  for (int i = 0; i < triangles.length; i++) {
    // Convert triangle and midpointlist entry to Sets for easy comparison
    Set<Offset> triangleSet = triangles[i].toSet();
    
    // Check if the triangle from `triangles` is in `midpointlist`
    bool isInMidpoint = false;
    for (var midpoint in midpointlist) {
      if (triangleSet.containsAll(midpoint.toSet()) && midpoint.toSet().containsAll(triangleSet)) {
        isInMidpoint = true;
        break;
      }
    }
    
    if (isInMidpoint) {
      // Update the `emptyList` with edge length
      if (i < emptyList.length && i < edgelengthlist.length) {
        try {
          double edgeLength = double.parse(edgelengthlist[i]);
          emptyList[i] = List.filled(emptyList[i].length, null);
          emptyList[i][0] = Offset(edgeLength, 0); // Storing edge length or other information
        } catch (e) {
          print('Error parsing edge length at index $i: ${edgelengthlist[i]}');
        }
      }
    } else {
      // Check in `diamidpoint` if not found in `midpointlist`
      bool isInDiamidpoint = false;
      for (var diamid in diamidpoint) {
        if (triangleSet.containsAll(diamid.toSet()) && diamid.toSet().containsAll(triangleSet)) {
          isInDiamidpoint = true;
          break;
        }
      }

      if (isInDiamidpoint) {
        // Update the `emptyList` with diagonal length
        if (i < emptyList.length && i < diagonallengthlist.length) {
          try {
            double diagonalLength = double.parse(diagonallengthlist[i]);
            emptyList[i] = List.filled(emptyList[i].length, null);
            emptyList[i][0] = Offset(diagonalLength, 0); // Storing diagonal length or other information
            
          } catch (e) {
            print('Error parsing diagonal length at index $i: ${diagonallengthlist[i]}');
          }
        }
      }
    }
  }

}