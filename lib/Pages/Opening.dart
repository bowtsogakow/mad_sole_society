import 'package:flutter/material.dart';
import 'package:sole_society/Pages/login.dart';
import 'package:sole_society/Pages/signup.dart' as sign_up;
import "package:sole_society/Database/database.dart" as DB;
import 'package:sole_society/Pages/Design.dart' as design;
class Opening extends StatelessWidget{

  @override 

  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor:Color(0xFFFAFAFA),
      body : Center(
        child: Column(
          children: [

            const Flexible (
              flex : 1, 
              fit : FlexFit.tight,
              child : SizedBox(height: 85),
            ),
            Image.asset(
              'lib/Icons/Cash-up-logo.png', 
              height : 210, 
              width : 350, 
              fit : BoxFit.cover, 
            ),

            const Flexible (
              flex : 0, 
              fit : FlexFit.loose,
              child : SizedBox(height: 170),
            ),

           
            Flexible(
              flex : 0, 
              fit : FlexFit.tight,
              child : SizedBox(
                height: 40,
                width: 250,
                child : ElevatedButton(
                  onPressed: () async {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const sign_up.sign_up()),
                    );
                    
                    print("hello");
                  },                 
                  child: const Text( // ignore: sort_child_properties_last
                    'SIGN UP',
                    style: design.text_style.text_style2, // Set text color,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFeb5e28), // Set button color
                    // backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                  ),              
                ),
              )
            ),

            const Flexible (
              flex : 1, 
              fit : FlexFit.loose,
              child : SizedBox(height: 25),
            ),

            Flexible(
              flex : 0, 
              fit : FlexFit.tight,
              child : SizedBox(
                height: 40,
                width: 250,
                child : ElevatedButton(
                  onPressed: () async {                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => log_in()),
                    );
                  },                 
                  child: const Text( // ignore: sort_child_properties_last
                    'LOG IN',
                    style: design.text_style.text_style2, // Set text color,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFeb5e28), // Set button color
                    // backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                  ),              
                ),
              )
            ),


          ],
          
        ),
      ),
    );
  }
}