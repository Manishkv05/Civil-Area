// import 'package:flutter/material.dart';
// import 'package:polycalculator/formula/scalingconvert.dart';
// import 'package:polycalculator/point.dart';

// class scaledpoly extends StatefulWidget {
//   List<Offset> positions=[];
//    List<String> edgelengthlist=[];
//    scaledpoly(this.positions, this.edgelengthlist, {super.key});

//   @override
//   State<scaledpoly> createState() => _scaledpolyState();
// }


// class _scaledpolyState extends State<scaledpoly> {
//     List<Offset> new_positions=[];
//   @override
//   void initState() {
//    new_positions= rescale();
//     // TODO: implement initState
//     super.initState();
//   }
//   rescale(){
// return rescalePolygon(widget.positions,widget.edgelengthlist);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: CustomPaint(painter: TouchPointPainter(new_positions),)
//     );
//   }
// }
// Use this in your Flutter widget to get the pixel density and pass it to the function



// import 'package:flutter/material.dart';
// import 'package:polycalculator/formula/scalingconvert.dart';
// import 'package:flutter/material.dart';
// import 'package:polycalculator/formula/scalingconvert.dart';

// class PolygonRescaleWidget extends StatelessWidget {
//   final List<Offset> originalPoints;
//   final List<String> edgeLengthList;

//   PolygonRescaleWidget({
//     required this.originalPoints,
//     required this.edgeLengthList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen pixel density (dots per inch, or DPI)
//     double dpi = MediaQuery.of(context).devicePixelRatio * 160; // Approx. 160 DPI per devicePixelRatio
//     double pixelsPerCm = dpi / 2.54; // Convert DPI to pixels per cm

//     // Rescale the polygon
//     List<Offset> rescaledPolygon = rescalePolygonToCm(originalPoints, edgeLengthList, pixelsPerCm);

//     // Calculate the bounding box of the polygon
//     double minX = rescaledPolygon.map((e) => e.dx).reduce((a, b) => a < b ? a : b);
//     double maxX = rescaledPolygon.map((e) => e.dx).reduce((a, b) => a > b ? a : b);
//     double minY = rescaledPolygon.map((e) => e.dy).reduce((a, b) => a < b ? a : b);
//     double maxY = rescaledPolygon.map((e) => e.dy).reduce((a, b) => a > b ? a : b);

//     // Add padding around the bounding box to prevent cropping
//     double padding = 50.0;
//     double width = (maxX - minX) + 2 * padding;
//     double height = (maxY - minY) + 2 * padding;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: InteractiveViewer(
//         minScale: 0.01, // Allow very far zoom out
//         maxScale: 100.0, // Allow very close zoom in
//         boundaryMargin: EdgeInsets.zero, // Allow panning beyond the edges
//         constrained: false,
//         child: Center(
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: CustomPaint(
//               painter: PolygonPainter(rescaledPolygon, Offset(padding - minX, padding - minY)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // A simple painter to visualize the rescaled polygon
// class PolygonPainter extends CustomPainter {
//   final List<Offset> points;
//   final Offset offset;

//   PolygonPainter(this.points, this.offset);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     if (points.isEmpty) return;

//     // Draw polygon with offset to center it in the canvas
//     Path path = Path()..moveTo(points[0].dx + offset.dx, points[0].dy + offset.dy);

//     for (int i = 1; i < points.length; i++) {
//       path.lineTo(points[i].dx + offset.dx, points[i].dy + offset.dy);
//     }
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class PolygonRescaleWidget extends StatefulWidget {
  final List<Offset> originalPoints;
  final List<String> edgeLengthList;

  PolygonRescaleWidget({
    required this.originalPoints,
    required this.edgeLengthList,
  });

  @override
  State<PolygonRescaleWidget> createState() => _PolygonRescaleWidgetState();
}

class _PolygonRescaleWidgetState extends State<PolygonRescaleWidget> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    checkAndRequestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    // Rescale the polygon to fit the device screen
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Rescale and center the polygon
    List<Offset> normalizedPolygon = normalizePolygon(
      widget.originalPoints,
      screenWidth,
      screenHeight,
      padding: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Polygon Rescale'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveScreenshot(context),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Screenshot(
        controller: _screenshotController,
        child: InteractiveViewer(
          minScale: 0.5, // Allow zooming out
          maxScale: 10.0, // Allow zooming in
          boundaryMargin: EdgeInsets.all(50), // Provide margin for panning
          constrained: false,
          child: Container(
            color: Colors.white,
            child: Center(
              child: CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: PolygonPainter(normalizedPolygon),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveScreenshot(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();

    String? documentName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Screenshot'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Enter document name',
              hintText: 'e.g., DOCID: 005',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context, textEditingController.text),
            ),
          ],
        );
      },
    );

    if (documentName == null || documentName.isEmpty) return;

    if (await Permission.storage.request().isGranted) {
      // Capture screenshot
      final image = await _screenshotController.capture();
      if (image != null) {
        final directory = await getExternalStorageDirectory();
        final path = '${directory?.path}/polycalculator';
        await Directory(path).create(recursive: true);

        final file = File('$path/$documentName.png');
        await file.writeAsBytes(image);

        // Save to gallery
        await ImageGallerySaver.saveImage(
          Uint8List.fromList(image),
          quality: 100,
          name: documentName,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Screenshot saved as $documentName.png')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to capture screenshot')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  Future<void> checkAndRequestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }

  /// Normalize the polygon points to fit within the display area
  List<Offset> normalizePolygon(
      List<Offset> points, double screenWidth, double screenHeight,
      {double padding = 0.0}) {
    double minX = points.map((e) => e.dx).reduce((a, b) => a < b ? a : b);
    double maxX = points.map((e) => e.dx).reduce((a, b) => a > b ? a : b);
    double minY = points.map((e) => e.dy).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((e) => e.dy).reduce((a, b) => a > b ? a : b);

    // Width and height of the bounding box
    double width = maxX - minX;
    double height = maxY - minY;

    // Scale to fit the screen with padding
    double scaleX = (screenWidth - 2 * padding) / width;
    double scaleY = (screenHeight - 2 * padding) / height;
    double scale = scaleX < scaleY ? scaleX : scaleY;

    // Offset to center the polygon on the screen
    double offsetX = (screenWidth - width * scale) / 2 - minX * scale;
    double offsetY = (screenHeight - height * scale) / 2 - minY * scale;

    // Apply scaling and offset to each point
    return points.map((p) => Offset(p.dx * scale + offsetX, p.dy * scale + offsetY)).toList();
  }
}

class PolygonPainter extends CustomPainter {
  final List<Offset> points;

  PolygonPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (points.isEmpty) return;

    // Draw polygon
    Path path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
