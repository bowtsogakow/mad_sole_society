// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sole_society/Pages/Admin_landing.dart';

import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as db;
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/Opening.dart';

class profile extends StatefulWidget {
  const profile({super.key, required this.user_info});
  final Map user_info; 

  @override
  State<profile> createState() => _profileState(user_info: user_info);
}

class _profileState extends State<profile> {
  final Map user_info;

  _profileState({required this.user_info});

  String username = ""; 
  String email = ""; 
  int user_id = 0; 
  String password_db = ""; 

  TextEditingController password = TextEditingController();
  TextEditingController new_password = TextEditingController(); 

  String error_password = ""; 

  db.user_db user = db.user_db(); 

  void match(){
    if(password.text != password_db){
      error_password = "Passwords do not match"; 
      
    }
    else{
      error_password = "";
      
    }
    
  }

  void initState(){
    super.initState(); 
    username = user_info["Username"] as String;
    email = user_info["Email"] as String; 
    user_id = user_info["user_id"] as int; 
    password_db = user_info["Password"] as String; 
  } 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 100,
                width: 350, 
                decoration: BoxDecoration(
                  border : Border.all(
                    color : design.custom_color.c_dark_blue,
                    width: 2,  
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children : [
                    ClipRect(
                      child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: design.custom_color.c_dark_blue,
                        shape: BoxShape.circle, 
                      ),
                      child: Icon(
                        Icons.person_sharp,
                        color : design.custom_color.c_offwhite,
                        size : 50.0
                        ),
                      ),
                    ),
      
                    Flexible(
                      flex : 0, 
                      fit : FlexFit.loose, 
                      child : SizedBox(width : 5), 
                    ),
      
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
      
                        SizedBox(
                          height: 10,
                        ),
                        
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "$username", 
                            style: design.text_style.text_style7,
                          ),
                        ), 
      
                        Flexible(
                          flex : 0, 
                          fit : FlexFit.loose, 
                          child : SizedBox(width : 5), 
                        ),
      
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "$email", 
                            style : design.text_style.text_style5, 
                          ),
                        ),
      
      
                      ],
      
                    ), 
                
                  ]
                ),
              ),
            ), 
      
      
      
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 280,
                width: 350, 
                decoration: BoxDecoration(
                  border : Border.all(
                    color : design.custom_color.c_dark_blue,
                    width: 2,  
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
      
                child : Column(
      
                  children : [
      
                    SizedBox(height: 10,), 
      
                    Text(
                      "Change Password", 
                      style : design.text_style.text_style1, 
                      ), 
      
                    SizedBox(height: 30,), 
      
                    SizedBox(
                      height: 50,
                      width: 250,
                      child: TextFormField(
                        controller : password,  
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          errorText: error_password,
                          errorStyle: TextStyle(height: 0.1, fontSize: 10),
                          errorMaxLines: 1,
                          labelText: 'Current Password', // Placeholder text
                          labelStyle: design.text_style.text_style1,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          focusedErrorBorder: design.input_border.focus,
                          errorBorder: design.input_border.error,
                          enabledBorder: design.input_border.enabled,
                          focusedBorder: design.input_border.focus,
                          ), 
                        ),
                      ),
      
                      SizedBox(height: 15,), 
      
                      SizedBox(
                      height: 40,
                      width: 250,
                      child: TextFormField(
                        controller : new_password, 
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          errorStyle: TextStyle(height: 0.1, fontSize: 10),
                          errorMaxLines: 1,
                          labelText: 'New Password', // Placeholder text
                          labelStyle: design.text_style.text_style1,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          focusedErrorBorder: design.input_border.focus,
                          errorBorder: design.input_border.error,
                          enabledBorder: design.input_border.enabled,
                          focusedBorder: design.input_border.focus,
                          ), 
                        ),
                      ),
      
                      SizedBox(height: 25,), 
      
      
                      SizedBox(
                        height: 30,
                        width: 250,
                        child : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              match(); 
                            });(); 

                            if(error_password == ""){
                              await user.change_password(user_id, new_password.text); 

                              // ignore: use_build_context_synchronously
                              showDialog(context: context, 
                                builder: (context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () async { 
                                        
                                        Navigator.pop(context,true); 
                                        Navigator.pop(context,true); 
                                        // ignore: use_build_context_synchronously

                                        if(user_id == 0){
                                          Navigator.push(
                                            context,
                                              MaterialPageRoute(builder: (context) => Admin_landing(user_id:user_id, index : 0)),
                                          );
                                        }

                                        else{
                                          Navigator.push(
                                            context,
                                              MaterialPageRoute(builder: (context) => Landing(user_id:user_id, index : 3)),
                                          );
                                        }

                                         }, 
                                      child: Text("Proceed")
                                    ),                            
                                  ],
                                  title : Text("Account Status"),
                                  contentPadding: EdgeInsets.all(20.0),
                                  content : Text("Password changed succesfully")
                                )
                              );
                              
                            }
                            else{
                              print("uyy"); 
                              print(error_password);
                            }
                          },                 
                          child: Text( // ignore: sort_child_properties_last
                            'CONFIRM',
                            style: design.text_style.text_style2, // Set text color,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: design.custom_color.c_dark_blue, // Set button color
                            // backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                          ),              
                        ),
                      )
      
                  ], 
                ), 
              ),
            ),
      
            SizedBox(height: 30,),
      
            SizedBox(
              height: 30,
              width: 250,
              child : ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context, true); 
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Opening(),)
                    );
                },                 
                child: Text( // ignore: sort_child_properties_last
                  'LOG OUT',
                  style: design.text_style.text_style2, // Set text color,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFeb5e28), // Set button color
                  // backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                ),              
              ),
            )
      
      
            
          ],
        )
      ),
    );
  }
}