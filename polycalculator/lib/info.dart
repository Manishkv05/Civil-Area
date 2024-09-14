import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';


class info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Info',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 9, 9, 9), // Green background as seen in the image
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: <Widget>[
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   
                      SvgPicture.asset(
            'lib/assets/flutter-svgrepo-com.svg', // Replace with your SVG URL
            height: 20.0, // Set height if necessary
            width: 20.0, // Set width if necessary
          ),
                        SvgPicture.asset(
            'lib/assets/android-logo-svgrepo-com.svg', // Replace with your SVG URL
            height: 20.0, // Set height if necessary
            width: 20.0, // Set width if necessary
          ),
           SvgPicture.asset(
            'lib/assets/os-apple-svgrepo-com.svg', // Replace with your SVG URL
            height: 20.0, // Set height if necessary
            width: 20.0, // Set width if necessary
          ),
           
                ],
              ),
              SizedBox(height: 20),
              Text(
                '"AreaCalc" aims to help civil engineers and architects to calculate the area of land of any shapes.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'How to start:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '1. Draw the perimeter of a land by tapping the vertices of a polygonal land on the screen.\n'
                '2. Draw diagonals by joining the vertices to form smaller triangles. Avoid Diagonals intersecting with each other.\n'
                '3. Click Length button which is at the top to set the length of each side and diagonals drawn.\n'
                '4. Then click Area the app will show you the area of the polygon in Sq.units.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Developed by:',
                style: TextStyle(
                   color: Color.fromARGB(255, 71, 245, 2),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            
                  Text(
                        "Manish K V",
                        style: TextStyle( color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                      ),
             
           
              Text("Hire me for professional Android, iOS, and web development services! Whether you're looking to build a mobile app, a responsive website, or need end-to-end software solutions, I've got you covered.", style: TextStyle(color: Colors.white, fontSize: 14)),
             // SizedBox(height: 10),
                Row(
                children: [
                     SvgPicture.asset(
            'lib/assets/placeholder-map-location-svgrepo-com.svg', // Replace with your SVG URL
            height: 20.0, // Set height if necessary
            width: 20.0, // Set width if necessary
          ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Karnataka, India",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: ()async{
                 _launchEmail();
        
                },
                child: Row(
                  children: [
                     SvgPicture.asset(
            'lib/assets/gmail-icon-logo-svgrepo-com.svg', // Replace with your SVG URL
            height: 18.0, // Set height if necessary
            width: 18.0, // Set width if necessary
          ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Text(
                        'Click here to Contact me through mail',
                        style: TextStyle(color:Color.fromARGB(255, 10, 61, 244), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
                GestureDetector(
                onTap: ()async{
                 launchUrl(Uri.parse('https://www.linkedin.com/in/manish-kv'));
        
                },
                child: Row(
                  children: [
                     SvgPicture.asset(
            'lib/assets/linkedin-svgrepo-com.svg', // Replace with your SVG URL
            height: 19.5, // Set height if necessary
            width: 19.5, // Set width if necessary
          ),
                    
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'Click here to Contact me through linkedin',
                        style: TextStyle(color: Color.fromARGB(255, 10, 61, 244), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Function to launch email app with the specified email ID
Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'manishkv0918@gmail.com',
      query: 'subject=Business%20Inquiry',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch email app');
    }
  }
}
