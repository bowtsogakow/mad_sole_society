// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:sole_society/Database/database.dart";
import 'package:flutter/material.dart';
import "package:sole_society/Pages/Design.dart" as design;



class authentication_methods {

  user_db DB = user_db(); 

  String ? validate_email(text){
    final pattern = RegExp(r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if(pattern.hasMatch(text)){
      return ""; 
    }
    else {
      return "Email is not valid";
    }
  }

  Future <String?> validate_email_exist(String email) async{
    Future status = await DB.email_exist(email); 

    if(status == true){
      return "Email is already registered"; 
    }
    else{
      return null; 
    }

  }

 Future <String?> validate_username_exist(String username) async{
    Future status = await DB.username_exist(username); 

    if(status == true){
      return "Username is already taken"; 
    }
    else{
      return null; 
    }

  }


  String? compare(String text1, String text2){
    if(text1 != text2){
      return "Passwords do not match"; 
    }else{
      return null; 
    }
  }

  String ? validate_empty(String? text){
    String ? error; 
    if(text?.isEmpty ?? true){
      error = "This field is required!";
    }
    else {
      error = null; 
    }
    return error;
  }
}

class sign_up extends StatefulWidget {
  const sign_up({super.key});
  @override
  State<sign_up> createState() => sign_up_state();
}

class sign_up_state extends State<sign_up>{

   // Initialize database and other proccesses  
  user_db DB = user_db();
  authentication_methods auth = authentication_methods();
  Border border = Border();

  // Text Editing controller for the form 
  TextEditingController username = TextEditingController(); 
  TextEditingController email = TextEditingController(); 
  TextEditingController password = TextEditingController(); 
  TextEditingController confirmPassword = TextEditingController();

  String? errorUsername = ""; 
  String? errorEmail = ""; 
  String? errorPassword = ""; 
  String? errorConfirmPassword = ""; 

  String? existUsername = ""; 
  String? existEmail = ""; 

  bool statusEmpty = false;

  Future username_email_exist() async {
    
    bool statusUsername = await DB.username_exist(username.text);
    bool statusEmail = await DB.email_exist(email.text); 

    print(statusUsername);
    print(statusEmail); 

    if(statusEmail == true){
      existEmail = "Username already exist!"; 
    }
    else if(statusEmail == false){
      existEmail = null; 
    }

    if(statusUsername == true){
      existUsername = "Email already exist!"; 
    }
    if(statusUsername == false){
      existUsername = null; 
    }

  }

  Future setEmptyError() async{
    
    setState(() {
      errorUsername = auth.validate_empty(username.text);
      errorEmail = auth.validate_empty(email.text);
      errorPassword = auth.validate_empty(password.text); 
      errorConfirmPassword = auth.validate_empty(confirmPassword.text); 

      if(errorPassword == null && errorConfirmPassword == null){
        errorConfirmPassword = auth.compare(password.text, confirmPassword.text);
      }

      // ignore: prefer_conditional_assignment
      if(errorEmail == null){
        errorEmail = auth.validate_email(email.text);
      } 
      
    });

    await username_email_exist();
    
    setState(() {
      if(errorEmail == null || errorUsername == null){
        errorEmail = existEmail; 
        errorUsername = existUsername;
      } 
    }); 

    

    
    if(errorUsername == null && errorEmail == null && errorPassword  == null && errorConfirmPassword == null){
      statusEmpty = true; 
    }
    else {
      statusEmpty = false; 
    }
  }
  

  @override
  Widget build (BuildContext context) {
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
                  
                  child : Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                    child : Column (
                      children : [

                        Flexible (
                          flex : 5, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 200),
                        ),                        
                        Flexible (
                          flex : 2, 
                          fit : FlexFit.loose,           
                          child :const Text(
                            "SIGN UP",
                            style : TextStyle(
                              fontFamily: "Poppins-2",
                              color: Color(0xFF130702), 
                              fontSize: 32,  
                            ),
                          ),
                        ), 


                        Flexible (
                          flex : 3, 
                          fit : FlexFit.loose,
                          child :const SizedBox(height: 50),
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
                                fillColor: Colors.white,
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
                          child :const SizedBox(height: 20),
                        ),
                        Flexible(
                          flex : 2, 
                          fit : FlexFit.tight,
                          child :SizedBox(
                            height: 30,
                            width: 250,
                            child: TextFormField(
                              controller : email, 
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                errorText: errorEmail,
                                errorStyle: TextStyle(height: 0.1, fontSize: 10),
                                errorMaxLines: 1,          
                                labelText: 'Email', // Placeholder text
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
                          fit : FlexFit.tight,
                          child : SizedBox(
                            height: 30,
                            width: 250,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: password,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
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
                        Flexible (
                          flex : 2, 
                          fit : FlexFit.tight,
                          child : SizedBox(
                            height: 30,
                            width: 250,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: confirmPassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                errorText: errorConfirmPassword,
                                errorStyle: TextStyle(height: 0.1, fontSize: 10),
                                errorMaxLines: 1,
                                labelText: 'Confirm Password', // Placeholder text
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
                                print(statusEmpty); 
                                if(statusEmpty == true){
                                  DB.add_user(username.text, email.text, password.text);
                                  username.clear(); 
                                  email.clear(); 
                                  password.clear(); 
                                  confirmPassword.clear(); 

                                  // ignore: use_build_context_synchronously
                                  showDialog(context: context, 
                                    builder: (context) => AlertDialog(
                                      actions: [
                                        TextButton(
                                          onPressed: (){ 
                                            Navigator.pop(context,true); 
                                            Navigator.pop(context,true);
                                            }, 
                                          child: Text("Proceed")
                                        ),                            
                                      ],
                                      title : Text("Account Status"),
                                      contentPadding: EdgeInsets.all(20.0),
                                      content : Text("Account application was successful. Please wait for approval!")
                                    )
                                  );
                                }
                                
                              },                 
                              child: Text( // ignore: sort_child_properties_last
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
          

            
            


                      ]
                      
                    )
                  )

                )






              )
            );
          }
        ), 

      ) 
    );
  }
}