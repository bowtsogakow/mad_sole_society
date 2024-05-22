// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;


class loan_history extends StatefulWidget {
  const loan_history({super.key,  required this.user_id});

  final int user_id; 
  @override
  State<loan_history> createState() => loan_history_state( user_id);
}

class loan_history_state extends State<loan_history> {
  
  final int user_id;

  DB.loan_funds_db loan = DB.loan_funds_db(); 
  loan_history_state(this.user_id, );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: design.custom_color.c_offwhite,
        appBar : AppBar(
          backgroundColor: design.custom_color.c_offwhite,
          title: const Text("Cash Up",
          style: design.text_style.text_style1,
          ),
        ),
        body : Center(
          child: FutureBuilder(
            future : loan.get_loan_history(user_id),
            builder : (context, snapshot){
              if(snapshot.hasData){
                List history = []; 
                history = snapshot.data as List;         
                if(history.isNotEmpty){
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
                                  "Loan History", 
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
                            itemCount: history.length,
                            itemBuilder: (context, index){
                              Map transaction_info = history[index].data(); 
                              String transaction = transaction_info["Loan_type"]; 
                              Timestamp timestamp = transaction_info["Date_start"];
                              DateTime test = timestamp.toDate(); 
                              String Date = design.formatDate(test); 
                              double Amount = transaction_info["Total_loan"].toDouble(); 
          
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child : Container(
                                  padding: EdgeInsets.all(10.0),
                                  height: 72,
                                  width : 350, 
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color : design.custom_color.c_dark_blue, 
                                      width: 2.0
                                    ),
                                  ),
                                  child : Column(
                                    children : [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text ("$transaction",
                                        style : design.text_style.text_style1),
                                      ), 
          
                                      Spacer(), 
          
                                      Row (
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("$Date", 
                                            style : design.text_style.text_style5),
                                          ), 
          
                                          Spacer(),
          
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text("Php $Amount", 
                                            style : design.text_style.text_style1),
                                          ), 
          
          
                                        ],
                                      )
                                      
                                      
                                      
                                      
          
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
                else{
                  return Text("You have not yet made your first transaction!");
                }
              }
              else{
                return CircularProgressIndicator(); 
              }
            }, 
          
              ),
        )
      ),
    ); 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
}

