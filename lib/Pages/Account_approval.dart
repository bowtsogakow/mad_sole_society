// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Admin_landing.dart';
import 'package:sole_society/Pages/Design.dart' as design;


class account_approval extends StatefulWidget {
  const account_approval({super.key, required this.accounts});

  final List accounts; 
  @override
  State<account_approval> createState() => account_approval_state(accounts : accounts);
}

class account_approval_state extends State<account_approval> {
  
  final List accounts;

  DB.user_db user_db = DB.user_db(); 

  account_approval_state({required this.accounts}); 
  @override
  Widget build(BuildContext context) {
    return Center(
      child : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child : Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
              color : design.custom_color.c_dark_blue,
              borderRadius: BorderRadius.circular(10),
            ),
              child: Center(
                child : Text(
                  "Account Applications Approval", 
                  style : design.text_style.text_style2,

                )
              ),
            ), 
          ),  

          Flexible(
            flex: 0,
            fit : FlexFit.loose,
            child: SizedBox( height: 20,),
          ),

          Expanded(
            child : ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index){
              Map account_info = accounts[index].data(); 
              String name = account_info["Username"];
              String email = account_info["Email"]; 
              int user_id = account_info["user_id"]; 

              return Padding(
                padding: EdgeInsets.all(10),
                child : Container(
                  padding: EdgeInsets.all(10.0),
                  height: 100,
                  width : 350, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color : design.custom_color.c_dark_blue, 
                      width: 2.0
                    ),
                  ),
                  child : Row(
                    children : [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text (name,
                              style : design.text_style.text_style1),
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text( email, 
                              style : design.text_style.text_style5),
                          ), 
                        ],
                      ), 

                      Spacer(), 

                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                            width : 135,
                            child: ElevatedButton(
                              onPressed: () async{
                                await user_db.approve_account(user_id); 
                                DB.cash_funds_db funds = DB.cash_funds_db(); 
                                await funds.create_fund(user_id);
                                Navigator.pop(context, true); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Admin_landing(user_id:0, index: 0,)),
                                ); 
                              }, 
                              child: Text( // ignore: sort_child_properties_last
                                    'APPROVED',
                                    style: design.text_style.text_style2, // Set text color,
                              ),
                              style: ElevatedButton.styleFrom(
                                    backgroundColor: design.custom_color.c_dark_blue, // Set button color
                                    // backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),     
                              ),
                            ),
                          ), 
                          
                          Spacer(),
                          
                          SizedBox(
                            height: 30,
                            width : 130,
                            child: ElevatedButton(
                              onPressed: () async {
                                await user_db.delete_account(user_id); 
                                Navigator.pop(context, true); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Admin_landing(user_id:0, index: 0,)),
                                ); 
                              }, 
                              child: Text( // ignore: sort_child_properties_last
                                    'REJECTED',
                                    style: design.text_style.text_style2, // Set text color,
                              ),
                              style: ElevatedButton.styleFrom(
                                    backgroundColor: design.custom_color.c_orange, // Set button color
                                    // backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),     
                              ),
                            ),
                          ),
                        ],
                      ), 
                      
                      
                       
                      

                    ],

                  ),
                )
                ); 
              
              
               })
              )


        ],
      )
    );
  }
}

