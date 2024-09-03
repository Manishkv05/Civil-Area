


import 'package:flutter/material.dart';
import 'package:polycalculator/firstandlast.dart';

import 'package:polycalculator/point.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       
        body: TouchPositionWidget(),
      ),
    );
  }
}

class TouchPositionWidget extends StatefulWidget {
  @override
  _TouchPositionWidgetState createState() => _TouchPositionWidgetState();
}

class _TouchPositionWidgetState extends State<TouchPositionWidget> {
  List<Offset> _touchPosition = [];
  List<Offset> positions=[];
  List<Offset> temp=[];
  List<List<Offset>> setDiagonal = [];
   final List<TextEditingController> _controllers = [];
  
  bool _iscompleted=false;
  var firstPoint;
  var secondPoint;
  bool _isdiagonal=false;
  bool _candraw=false;
  @override
  void initState() {
       super.initState();
    
    // TODO: implement initState
 
  }
  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  setinputplaceholde(){
     for (int i = 0; i <_touchPosition.length - 1; i++) {
      _controllers.add(TextEditingController());
    }
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Touch Position Example'),
          actions: [TextButton(onPressed: (){  setinputplaceholde();}, child: Text('hi')),
            TextButton(onPressed: () {setState(() {
             _iscompleted=false;
            positions.clear();
            temp.clear();
            _touchPosition.clear();
            setDiagonal.clear();
            _isdiagonal=false;
            _candraw=false;
          });  },
          child:Icon(Icons.replay_outlined),),
           TextButton(
            onPressed: () {
              
             temp.clear();
              if (positions.length >= 4) {
                if(_iscompleted)
                setState(() {
                 _isdiagonal=true;
                });
              }
            },
            child: Text("Set Diagonal", style: TextStyle(color: const Color.fromARGB(255, 14, 13, 13))),
          ),]
        ),
      body: GestureDetector(
      
      
        onTapDown: (TapDownDetails details) {
                   if(_iscompleted){
    //                   setState(() {
                        
    // const double threshold = 10.0; // Define how close is "close enough"
    // return (tapPosition - touchPoints.first).distance < threshold;
  
    //       temp.add(details.localPosition);
          
    //               // Create diagonals between the last two points
                 
                
       

         
    //   });
    setState(() {
       
    for (Offset p in positions) {
      if ((p.dx - details.localPosition.dx).abs() < 20 && (p.dy - details.localPosition.dy).abs() < 20) {
        temp.add(p); // Position is considered present
      }
    
   // Position is not present
  }
      
    });
   

               
             

      if(_isdiagonal){
      if (temp.length >= 2) {
                    Offset lastPoint = temp.last;
                    Offset secondLastPoint = temp[temp.length - 2];
                    setDiagonal.add([secondLastPoint, lastPoint]);
                  }
     
    
      }

       
      
      //if(diagonals.length==1)
      // for (int i = 0; i < positions.length; i++) {
      //  Offset currentPoint = diagonals[0];
      // Offset nextPoint = diagonals[(0+1) % positions.length]; // Circular index

      // if (currentPoint != nextPoint) {
        // _candraw=true;
      // }
      // }
        
      
   
  
}
else   if (positions.isNotEmpty && _isCloseToFirstPoint(details.localPosition)) {
              // Show "Done" popup
                showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Drawing Completed"),
          content: Text("You have completed the drawing."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                    print('hi${positions}');
                    print(temp);
                    print('bi{$setDiagonal}');
          
                  _iscompleted=true;
                  _touchPosition.add(positions.first);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  
            } else
        

          setState(() {
          
             _touchPosition.add(details.localPosition);
          
        positions.add(details.localPosition);
       
            
          
      
          });
        
        
        },
       
        child: Stack(
          children:[ CustomPaint(
            painter: TouchPointPainter(_touchPosition),
          foregroundPainter:DiagonalPainter(setDiagonal),
          child: Container(
            
           // color: const Color.fromARGB(255, 136, 137, 140),
            child: Center(
              child: Text(
                'Touch anywhere on the screen',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
                ),
               
          ]
        ),
      ),
    );
  }
  bool _isCloseToFirstPoint(Offset tapPosition) {
    const double threshold = 10.0; // Define how close is "close enough"
    return (tapPosition - positions.first).distance < threshold;
  }
}
