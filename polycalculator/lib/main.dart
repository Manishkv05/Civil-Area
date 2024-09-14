


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:polycalculator/formula/area.dart';
import 'package:polycalculator/formula/triangles.dart';
import 'package:polycalculator/info.dart';
import 'package:polycalculator/textplace.dart';
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
    late final TextEditingController _length;
     List<Offset> midpoints = [];
     List<Offset> dmidpoints=[];
     List<String> edgelengthlist=[];
     List<String> diagonallengthlist=[];
     double area=0.0;
      
  List<TextEditingController> edgetextControllers = [];
  List<TextEditingController> diagonaltextControllers = [];
  
  bool _iscompleted=false;
  bool _setlength=false;
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
      backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor:Colors.blueAccent,
          title: Row(
            children: [
              Container(width: 100,child: Center(child: Text(area.toString(),style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),)),decoration:BoxDecoration(borderRadius:  BorderRadius.circular(10),border: Border.all(width: 2,color: Colors.black),)),
              Text('sq.units',style: TextStyle(color: Colors.red,fontSize: 13.5,fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [GestureDetector(
            onTap:  (){
                     List<List<double>> triangles = calculateTriangleSides(
                    positions,
                    setDiagonal,
                    edgelengthlist,
                    diagonallengthlist,
                    midpoints,
                    dmidpoints,
                    
                  );
                   double area1 = calculatePolygonAreaFromSides(triangles);
                   print(area);
                  setState(() {
                    area=area1;
                  });
                // List<List<double?>> emptyList = List.generate(
                //   triangles.length,
                //   (i) => List<double?>.filled(triangles[i].length, null),
                // );
                
                
                  //  updateListWithEdgeOrDiagonalLengths(triangles, midpoints, dmidpoints, edgelengthlist, diagonallengthlist, emptyList);
                  print(triangles);
                  },
            child: Container(decoration:BoxDecoration(borderRadius:  BorderRadius.circular(10),
          
            border: Border.all(width: 2,color: Colors.black),),
              width:80,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20),
                child: Text('Area',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(width: 10,),
                    
                    GestureDetector(
                      onTap:(){  setState(() {
                                _setlength=true;
                                 calculateMidpoints();
                                 diagonalcalculateMidpoints();
                        });} ,
                      child: Container(
                        width: 80,
                        decoration:BoxDecoration(borderRadius:  BorderRadius.circular(10),border: Border.all(width: 2,color: Colors.black),),
                        child: Padding(
                          padding:const EdgeInsets.symmetric(vertical: 5.0,horizontal: 13),
                          child: Text('Length',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                      GestureDetector(
                        onTap:  () {setState(() {
                                   _iscompleted=false;
                                  positions.clear();
                                  temp.clear();
                                  _touchPosition.clear();
                                  setDiagonal.clear();
                                  midpoints.clear();
                                  dmidpoints.clear();
                                  _isdiagonal=false;
                                  _candraw=false;
                                   edgetextControllers.clear();
                                   diagonaltextControllers.clear(); 
                                   edgelengthlist.clear();
                                   area=0.0;

                        });  },
                        child: Container(
                                          decoration:BoxDecoration(borderRadius:  BorderRadius.circular(30),border: Border.all(width: 2,color: Colors.black),),
                                  child: Icon(Icons.replay_circle_filled_outlined,weight:100,color:Colors.red,),
                        ),
                      ),
                      SizedBox(width: 5,),
      ]
      
        ),
      body: Stack(
        children:[ GestureDetector(
        
        
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
                      temp.clear();
                    }
             
            
        }
        
         
        
            
          
        
           
          
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
                    temp.clear();
                if (positions.length >= 4) {
                  if(_iscompleted)
                  
                   _isdiagonal=true;
                  
                }
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
              painter: DiagonalPainter(setDiagonal),
            foregroundPainter:TouchPointPainter(_touchPosition),
            child: 
          Stack(children:[ Container(),
            //     CustomPaint(
            //      painter: TextPlaceholderPainter(midpoints,dmidpoints),
            //    child: Container(),
              
            // ),
              if (_setlength)
              ...midpoints.map((midpoint) {
                int index = midpoints.indexOf(midpoint);
                return Positioned(
                  left: midpoint.dx-30, // Adjust positioning as needed
                  top: midpoint.dy-10,
                  child: Container(
        
                   // color: const Color.fromARGB(255, 77, 117, 186),
                width: 100,
                    height: 50.55,
                    child: TextField(
                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                        maxLines: null,
                      minLines: 1,
                      controller: edgetextControllers[index],
                     
                       keyboardType:TextInputType.number,
                     
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                  
                        hintText: 'Add',
                        hintStyle:TextStyle(fontSize: 15,color: Colors.black),
                         enabledBorder: OutlineInputBorder(         // Border color when not focused
        borderSide: BorderSide(color: const Color.fromARGB(0, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(         // Border color when focused
        borderSide: BorderSide(color: Color.fromARGB(255, 29, 248, 5)),
            ),
                        
                      ),
                      
                        onSubmitted:(value){
                          setState(() {
                            edgelengthlist[index]=value;
                          });
                          
                        
                          print(edgelengthlist);
                        }
                        
                    ),
                  ),
                );
              }).toList(),
              ...dmidpoints.map((midpoint) {
                int index = dmidpoints.indexOf(midpoint);
                return Positioned(
                  left: midpoint.dx-25 , // Adjust positioning as needed
                  top: midpoint.dy ,
                  child: Container(
                  // color: Colors.green,
                    width: 100,
                    height: 50.55,
                    child: TextField(
                         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                      maxLines: null,
                      minLines: 1,
                      keyboardType:TextInputType.number,
                      controller: diagonaltextControllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add',
                      hintStyle:TextStyle(fontSize: 15,color: Colors.black),
                        enabledBorder: OutlineInputBorder(         // Border color when not focused
        borderSide: BorderSide(color: const Color.fromARGB(0, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(         // Border color when focused
        borderSide: BorderSide(color: Color.fromARGB(255, 29, 248, 5)),
            ),
                        
        
                      ),
                        onSubmitted:(value){
                          setState(() {
                            diagonallengthlist[index]=value;
                          });
                        
                          print(edgelengthlist);
                          print(diagonallengthlist);
                        }
                    ),
                  ),
                );
              }).toList(),
               
            ]),
            
              
             // color: const Color.fromARGB(255, 136, 137, 140),
                 ),
            
                 
           
            
          
                 
            ]
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.9 ),
          child: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => info(),));
          
          }, icon: Icon(Icons.info_rounded,color: Colors.black,)),
        )
        ],
      ),
    );
  }
  bool _isCloseToFirstPoint(Offset tapPosition) {
    const double threshold = 35.0; // Define how close is "close enough"
    return (tapPosition - positions.first).distance < threshold;
  }

  void calculateMidpoints() {
    midpoints.clear();
    for (int i = 0; i < _touchPosition.length-1; i++) {
      Offset p1 = _touchPosition[i];
      Offset p2 = _touchPosition[i + 1];
      Offset midpoint = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );
      midpoints.add(midpoint);
       edgetextControllers.add(TextEditingController()); 
        edgelengthlist.add(''); 
    }

    // Handle the midpoint between the first and last point
   
  }
   void diagonalcalculateMidpoints() {
    dmidpoints.clear();
      diagonaltextControllers.clear(); // Ensure these lists are cleared before adding new items
  diagonallengthlist.clear();
   print('Processing setDiagonal, length: ${setDiagonal.length}, contents: $setDiagonal');
    for (int i = 0; i < setDiagonal.length; i++) {
      List<Offset> t=setDiagonal[i];
  print('Processing setDiagonal[$i], length: ${t.length}, contents: $t');
      if (t.length == 2) {
      Offset p1 = t[0];
      Offset p2 = t[1];
      Offset midpoint = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );
      dmidpoints.add(midpoint);
       diagonaltextControllers.add(TextEditingController()); 
        diagonallengthlist.add(''); 
        print(dmidpoints);
        print(diagonallengthlist);
    
    }
    }

    
   
  }
//   void updateListWithEdgeOrDiagonalLengths(
//   List<List<double>> triangles,
//   List<Offset> midpointlist,
//   List<Offset> diamidpoint,
//   List<String> edgelengthlist,
//   List<String> diagonallengthlist,
//   List<List<double?>> emptyList,
// ) {
//   for (int i = 0; i < triangles.length; i++) {
//     // Convert triangle to a Set for easy comparison
//     Set<double> triangleSet = triangles[i].toSet();

//     // Check if the triangle is in `midpointlist`
//     bool isInMidpoint = false;
//     for (var midpoint in midpointlist) {
//       // Use Set to compare
//       if (triangleSet.contains(midpoint)) {
//         isInMidpoint = true;
//         break;
//       }
//     }

//     if (isInMidpoint) {
//       // Update the `emptyList` with edge length
//       if (i < emptyList.length && i < edgelengthlist.length) {
//         try {
//           double edgeLength = double.parse(edgelengthlist[i]);
//           emptyList[i] = List.filled(emptyList[i].length,0.0);
//           emptyList[i][0] = edgeLength; // Storing edge length or other information
//         } catch (e) {
//           print('Error parsing edge length at index $i: ${edgelengthlist[i]}');
//         }
//       }
//     } else {
//       // Check in `diamidpoint` if not found in `midpointlist`
//       bool isInDiamidpoint = false;
//       for (var diamid in diamidpoint) {
//         // Use Set to compare
//         if (triangleSet.contains(diamid)) {
//           isInDiamidpoint = true;
//           break;
//         }
//       }

//       if (isInDiamidpoint) {
//         // Update the `emptyList` with diagonal length
//         if (i < emptyList.length && i < diagonallengthlist.length) {
//           try {
//             double diagonalLength = double.parse(diagonallengthlist[i]);
//             emptyList[i] = List.filled(emptyList[i].length, 0.0);
//             emptyList[i][0] = diagonalLength; // Storing diagonal length or other information
//           } catch (e) {
//             print('Error parsing diagonal length at index $i: ${diagonallengthlist[i]}');
//           }
//           finally{
//               double area = calculatePolygonAreaFromSides(emptyList);
//               print(area);
//           }
//         }
//       }
//     }
//   }
  
// }

}
