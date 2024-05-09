// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Design.dart' as design;


class transaction extends StatefulWidget {
  const transaction({super.key, required this.history});

  final List history; 
  @override
  State<transaction> createState() => _transactionState(history: history);
}

class _transactionState extends State<transaction> {
  
  final List history;


  _transactionState({required this.history});
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
                  "Transaction History", 
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
              String transaction = transaction_info["Transaction"]; 
              Timestamp timestamp = transaction_info["Date"];
              DateTime test = timestamp.toDate(); 
              String Date = design.formatDate(test); 
              double Amount = transaction_info["Amount"].toDouble(); 

              return Padding(
                padding: EdgeInsets.all(10),
                child : Container(
                  padding: EdgeInsets.all(10.0),
                  height: 70,
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
                            child: Text("PHP ${Amount.toStringAsFixed(2)}"),
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
}

