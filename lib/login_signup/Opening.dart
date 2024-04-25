import 'package:flutter/material.dart';
import 'package:sole_society/login_signup/login.dart';
import "package:sole_society/login_signup/signup.dart" as sign_up;
import "package:sole_society/Database/database.dart" as DB;
class Opening extends StatelessWidget{

  @override 

  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body : Center(
        child: Column(
          children: [

            const Flexible (
              flex : 5, 
              fit : FlexFit.loose,
              child : SizedBox(height: 200),
            ),
            Image.asset(
              'lib/Icons/Logo-Mad.png', 
              height : 120, 
              width : 250, 
              fit : BoxFit.cover, 
            ),

            const Flexible (
              flex : 4, 
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
                  child: Text( // ignore: sort_child_properties_last
                    'SIGN UP',
                    style: sign_up.sign_up_text_style.sign_up_text_style2, // Set text color,
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
                  child: Text( // ignore: sort_child_properties_last
                    'LOG IN',
                    style: sign_up.sign_up_text_style.sign_up_text_style2, // Set text color,
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