// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Design.dart' as design;

class small_receipt extends StatefulWidget {
  const small_receipt({super.key, required this.user_id});

  final int user_id;
   
  @override
  State<small_receipt> createState() => _small_receiptState(user_id: user_id);
}

class _small_receiptState extends State<small_receipt> {
  
  _small_receiptState({required this.user_id});

  final int user_id;
  DB.receipt receipt = DB.receipt(); 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future : receipt.get_receipt_id(user_id),
              builder : (context, snapshot){
                if(snapshot.hasData){
                  int transaction_id = snapshot.data; 

                  if(transaction_id != null){
                     
                    return FutureBuilder(
                      future: receipt.get_receipt(transaction_id), 
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          Map receipt_info = snapshot.data as Map;

                          if(receipt_info == null){
                            return Text("$snapshot");
                          } 
                          
                          else{
                            Timestamp timestamp = receipt_info["Date"];
                            DateTime test = timestamp.toDate(); 
                            String Date = design.formatDate(test); 
                            String Transaction = receipt_info["Transaction"]; 
                            double Amount = receipt_info["Amount"]
                            ; 

                            return Center(
                              child: Column(
                                children: [
                                   

                                  Flexible(
                                    flex : 0, 
                                    child: SizedBox(
                                      height: 10,
                                    )), 

                                  Row(
                                    children: [
                                      Text(
                                        "Transaction : ",
                                        style: design.text_style.text_style6,
                                      ),
                                      Spacer(),
                                      Text(
                                        Transaction, 
                                        style: design.text_style.text_style6,
                                      ),
                                    ],
                                  ),

                                  Flexible(
                                    flex : 0, 
                                    child: SizedBox(
                                      height: 10,
                                  )),

                                  Row(
                                    children: [
                                      Text(
                                        "Amount : ", 
                                        style: design.text_style.text_style6,
                                        ),
                                      Spacer(),
                                      Text(
                                        "PHP ${Amount.toStringAsFixed(2)}",
                                        style: design.text_style.text_style6,
                                        ),
                                    ],
                                  ), 

                                  Flexible(
                                    flex : 0, 
                                    child: SizedBox(
                                      height: 10,
                                  )),

                                  Row(
                                    children: [
                                      Text(
                                        "Date : ",
                                        style: design.text_style.text_style6,
                                        ),
                                      Spacer(),
                                      Text(
                                        "$Date",
                                        style: design.text_style.text_style6,
                                        ),
                                    ],
                                  ),



                                ],
                              ),
                            );
                          }

                        }
                        else{
                          return Text("Loading...");
                        }
                      }
                      );
                  }
                  else{
                    return Text("$snapshot.error");                   }
                }
                else{
                  return Text("Loading..."); 
                }
              }, 
            );
  }
}