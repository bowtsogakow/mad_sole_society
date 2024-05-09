// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Admin_landing.dart';
import 'package:sole_society/Pages/Design.dart' as design;


class loan_approval extends StatefulWidget {
  const loan_approval({super.key, required this.loan});

  final List loan; 
  @override
  State<loan_approval> createState() => loan_approval_state(loan : loan);
}

class loan_approval_state extends State<loan_approval> {
  
  final List loan;
  loan_approval_state({required this.loan}); 

  DB.loan_funds_db loan_db = DB.loan_funds_db();

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
                  "Loan Applications Approval", 
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
            itemCount: loan.length,
            itemBuilder: (context, index){
              Map info = loan[index]; 
              Map user_info = info["user_info"]; 
              Map loan_info = info["loan_info"];
              String name = user_info["Username"];
              String email = user_info["Email"]; 
              String loan_type = loan_info["Loan_type"]; 
              double initial_amount = loan_info["Initial_amount"].toDouble(); 
              double interest_rate = loan_info["Interest_rate"].toDouble();
              double interest = loan_info["Interest"].toDouble(); 
              double total_loan = loan_info["Total_loan"].toDouble();
              int loan_id = loan_info["Loan_id"];
              int user_id = user_info["user_id"]; 

              return Padding(
                padding: EdgeInsets.all(10),
                child : Container(
                  padding: EdgeInsets.all(10.0),
                  height: 220,
                  width : 350, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color : design.custom_color.c_dark_blue, 
                      width: 2.0
                    ),
                  ),
                  child : Column(

                    children: [

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Username",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text (name,
                              style : design.text_style.text_style8),
                          )

                        ]
                      ),

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Email",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text (email,
                              style : design.text_style.text_style8),
                          )

                        ]
                      ),

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Loan Type",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text (loan_type,
                              style : design.text_style.text_style8),
                          ),

                        ]
                      ),

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Initial Amount",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("PHP ${initial_amount.toStringAsFixed(2)}",
                              style : design.text_style.text_style8),
                          )

                        ],
                      ), 

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Interest Rate",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("$interest_rate",
                              style : design.text_style.text_style8),
                          )

                        ],
                      ), 

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Interest",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("PHP $interest",
                              style : design.text_style.text_style8),
                          )

                        ],
                      ), 

                      Spacer(),

                      Row(
                        children : [
                          
                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("Total Loan",
                              style : design.text_style.text_style8),
                          ), 

                          Spacer(), 

                          Align(
                          alignment: Alignment.topLeft,
                          child: Text ("PHP $total_loan",
                              style : design.text_style.text_style8),
                          )

                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      

                      Row(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 30,
                            width : 135,
                            child: ElevatedButton(
                              onPressed: () async {
                                await loan_db.approve_loan(loan_id); 
                                Navigator.pop(context, true); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Admin_landing(user_id:0, index: 1,)),
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
                          
                          SizedBox(
                            width: 30,
                          ),
                        
                          
                          SizedBox(
                            height: 30,
                            width : 130,
                            child: ElevatedButton(
                              onPressed: () async {
                                await loan_db.delete_loan(loan_id); 
                                Navigator.pop(context, true); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Admin_landing(user_id:0, index: 1,)),
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
                          Spacer(),
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


