// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/Receipt.dart' as receipt_widget; 
import 'package:sole_society/Pages/Loan_history.dart';

class loan extends StatefulWidget {
  const loan({super.key, this.loan_info});

  final Map ? loan_info;

  @override
  State<loan> createState() => loan_state(loan_info);
}

class loan_state extends State<loan> {

  loan_state(this.loan_info);

  final Map ? loan_info;
 
  dynamic outstanding_balance = 0; 
  String ?date_end = ""; 
  int user_id = -1; 
  int loan_id = -1;
  TextEditingController amount = TextEditingController(); 

  DB.loan_funds_db loan = DB.loan_funds_db();
  DB.receipt receipt = DB.receipt(); 

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    user_id = loan_info!["User_id"] as int;
    if(loan_info!["Outstanding_balance"] == null){
      outstanding_balance = "Please wait a moment"; 
      date_end = null; 
      
    }
    else{
      outstanding_balance = loan_info!["Outstanding_balance"];
    }
    loan_id = loan_info!["Loan_id"];
    Timestamp timestamp = loan_info!["Date_end"];
    DateTime test = timestamp.toDate(); 
    date_end = design.formatDate(test); 
  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [

        Padding(
          padding: const EdgeInsets.all(5.0),
          child : Container(
            padding: EdgeInsets.all(15.0),
            height: 100,
            width: 350, 
            decoration: BoxDecoration(
              color : design.custom_color.c_dark_blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child : Column(
              children: [
                Row(
                  children : [
                    const Align(
                      alignment: Alignment.topLeft,
                      child : Text(
                        "Outstanding Loan",
                        style : design.text_style.text_style2,
                      ), 
                    ),

                    const Flexible (
                    flex : 0, 
                    fit : FlexFit.loose,
                    child :SizedBox(width: 60),
                    ),       

                    Container(
                        child: 
                          Text(
                            "Due $date_end",
                            style: design.text_style.text_style4,
                          ),
                      )
                    
                  ], 
                ),

                const Flexible (
                  flex : 0, 
                  fit : FlexFit.loose,
                  child :SizedBox(height: 5),
                ),       

                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child : Text(
                        "PHP $outstanding_balance",
                        style : design.text_style.text_style3,
                      ), 
                    ),

                    SizedBox(
                      width : 150
                    ),

                    
                  ],
                ),

              ],
            )
            
          ),  
        ), 


        const Flexible (
          flex : 0, 
          fit : FlexFit.loose,
          child :SizedBox(height: 15),
        ),  

        IconButton(
          onPressed: (){
             
             showDialog(context: context, 
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () async { 
                        double amount2 = double.parse(amount.text); 
                        String transaction = "Pay Loan"; 
                        await loan.pay_loan(loan_id, amount2);
                        await receipt.add_recepit(user_id, transaction, amount2); 
                        
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            actions : [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context, true);
                                  Navigator.pop(context, true);
                                  Navigator.pop(context, true);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: ((context) => Landing(user_id: user_id, index : 1))));  
                                
                                }, 
                                child: Text("Proceed")
                                )
                            ],
                            title: Text("Transaction Receipt"),
                            contentPadding: EdgeInsets.all(20.0),
                            content : SizedBox(
                              width: 200,
                              height: 120,
                              child : receipt_widget.small_receipt(user_id: user_id)
                            ) , 
                          ));
                         }, 
                      child: Text("Confirm")
                    ),                            
                  ],
                  title : Text("Account Status"),
                  contentPadding: EdgeInsets.all(20.0),
                  content :  TextField(
                          controller: amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        )
                )
              );
          }, 
          icon: Icon(Icons.arrow_upward_rounded,
          color: design.custom_color.c_orange,
          ),
        ), 
        
        Text(
            "Pay Loan"
          ), 

        const Flexible (
          flex : 5, 
          fit : FlexFit.loose,
          child :SizedBox(height: 230),
        ), 

        SizedBox(
          height: 40,
          width: 250,
          child : ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => loan_history(user_id: user_id,))));  
                
              
            },
            child: Text( // ignore: sort_child_properties_last
              'VIEW PAST LOANS',
              style: design.text_style.text_style2, // Set text color,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: design.custom_color.c_orange, // Set button color
              // backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
            ),   
          ),
        )
         



      ]
    ); 
  }
}

