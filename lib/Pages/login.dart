// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/signup.dart' as sign_up;
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as db;
import 'package:sole_society/Pages/Admin_landing.dart';

class log_in extends StatefulWidget {
 

  @override
  State<log_in> createState() =>  log_in_State();
}

class  log_in_State extends State<log_in> {


  db.user_db DB = db.user_db();
  sign_up.authentication_methods auth = sign_up.authentication_methods();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController(); 

  String? errorUsername = ""; 
  String? errorPassword = ""; 

  bool statusEmpty = false;
  bool match = false; 

  Future setMatch() async {
    bool status = await DB.account_match(username.text, password.text);
    if(status == true){
      match = true; 
    }
    else{
      match = false; 
    }
  }

  Future setEmptyError() async{

    setState(() {
      errorUsername = auth.validate_empty(username.text);
      errorPassword = auth.validate_empty(password.text); 
    });

    await setMatch(); 
    
    setState(() {
      if(match == false){
      errorUsername = "Credentials do not match our system"; 
      errorPassword = "Credentials do not match our system";
      }
     
    });
    
    

    if(errorUsername == null && errorPassword  == null){
      statusEmpty = true; 
    }
    else {
      statusEmpty = false; 
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center (
        child : LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child : ConstrainedBox(
                constraints: constraints.copyWith(
                  maxHeight: constraints.maxHeight
                ),
                child: FractionallySizedBox(

                  widthFactor: 0.85, 
                  heightFactor: 0.9,

                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child : Column (
                      children: [

                        Flexible (
                          flex : 5, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 200),
                        ),          
                        Flexible (
                          flex : 2, 
                          fit : FlexFit.loose,           
                          child :const Text(
                            "LOG IN",
                            style : TextStyle(
                              fontFamily: "Poppins-2",
                              color: Color(0xFF130702), 
                              fontSize: 32, 
                            ),
                          ),
                        ), 


                        Flexible (
                          flex : 4, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 100),
                        ),
                        Flexible(
                          flex : 2,  
                          fit: FlexFit.tight,
                          child :SizedBox(
                            height: 30,
                            width: 250,
                            child: TextFormField(
                              controller : username, 
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                errorText: errorUsername,
                                errorStyle: TextStyle(height: 0.1, fontSize: 10),
                                errorMaxLines: 1,
                                labelText: 'Username', // Placeholder text
                                labelStyle: design.text_style.text_style1,
                                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                focusedErrorBorder: design.input_border.focus,
                                errorBorder: design.input_border.error,
                                enabledBorder: design.input_border.enabled,
                                focusedBorder: design.input_border.focus,
                                ), 
                              ),
                            ),
                          ),


                          Flexible (
                          flex : 1, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 10),
                        ),
                        Flexible(
                          flex : 2,  
                          fit: FlexFit.tight,
                          child :SizedBox(
                            height: 30,
                            width: 250,
                            child: TextFormField(
                              controller : password, 
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                errorText: errorPassword,
                                errorStyle: TextStyle(height: 0.1, fontSize: 10),
                                errorMaxLines: 1,
                                labelText: 'Password', // Placeholder text
                                labelStyle: design.text_style.text_style1,
                                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                focusedErrorBorder: design.input_border.focus,
                                errorBorder: design.input_border.error,
                                enabledBorder: design.input_border.enabled,
                                focusedBorder: design.input_border.focus,
                                ), 
                              ),
                            ),
                          ),


                        Flexible (
                          flex : 1, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 20),
                        ),
                        Flexible(
                          flex : 2, 
                          fit : FlexFit.loose,
                          child : SizedBox(
                            height: 40,
                            width: 250,
                            child : ElevatedButton(
                              onPressed: () async {
                                
                                await setEmptyError();
                                if(statusEmpty == true){
                                 
                                  showDialog(context: context, 
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                          onPressed: () async { 
                                            int user_id = await DB.get_ID(username.text, password.text) as int;
                                            
                                            Navigator.pop(context,true); 
                                            Navigator.pop(context,true); 
                                            Navigator.pop(context,true); 

                                            if(user_id == 0){

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Admin_landing(user_id:user_id, index: 0,)),
                                              ); 

                                            }

                                            else{
                                                Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => Landing(user_id:user_id, index : 0 )),
                                              ); 
                                            
                                            }
                                              
                                            
                                            }, 
                                          child: Text("Proceed")
                                        ),                            
                                      ],
                                      title : Text("Account Status"),
                                      contentPadding: EdgeInsets.all(20.0),
                                      content : Text("Logged in succesfully")
                                    )
                                  );

                                }
                                
                              },                 
                              child: Text( // ignore: sort_child_properties_last
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
                    )
                  ),
                )
              )
            );
          }
        )
      )
    );
  }

}