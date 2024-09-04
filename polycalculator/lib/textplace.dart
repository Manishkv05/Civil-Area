
  // // import 'package:flutter/material.dart';



  // //  _showDonePopup(BuildContext context) {

  //       Container(
  //                       child:((){
                        
  //        for(var pair in positions) {
  //         if(pair.length=>2)
    
  //     final dx=pair[0].dx-pair[1].dx;
  //     final dy=pair[0].dy-pair[1].dy;

      
      
  
  //          return  TextField(
  //               keyboardType:TextInputType.emailAddress,
  //               autocorrect:false,
  //               enableSuggestions:false,
  //               controller:_length,
  //               decoration: InputDecoration(
  //                 hintText: 'value'
  //               ),
  //            onSubmitted: (_length){
  //             setState(() {
                
  //                 final value=_length;
  //                 print(value);
  //             });
             

  //            }, );
  //  } }())),
  import 'package:flutter/material.dart';

class TextPlaceholderPainter extends CustomPainter {
  final List<Offset> midpoints;
  final List<Offset> dmidpoints;

  TextPlaceholderPainter(this.midpoints,this.dmidpoints);

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (Offset midpoint in midpoints) {
      textPainter.text = TextSpan(
        text: "Text",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              midpoint.dx - textPainter.width / 2, midpoint.dy - textPainter.height / 2));
    }
        for (Offset midpoint in dmidpoints) {
      textPainter.text = TextSpan(
        text: "Text",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              midpoint.dx - textPainter.width / 2, midpoint.dy - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}