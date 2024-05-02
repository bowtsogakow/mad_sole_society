// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Landing.dart';

class balance extends StatefulWidget {
  const balance({super.key, required this.fund});
  final Map fund; 
  @override
  State<balance> createState() => balance_state(fund);
}

class balance_state extends State<balance> {

  balance_state(this.fund_info); 
  
  Map fund_info;
  double Balance = 0; 
  int user_id = -1; 
  String peso_sign = "₱"; 
  TextEditingController deposit = TextEditingController();
  TextEditingController send = TextEditingController();
  TextEditingController withdraw = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("yehey"); 
    Balance = fund_info["Net_contribution"];  
    user_id = fund_info["User_id"] as int; 

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
                const Align(
                  alignment: Alignment.topLeft,
                  child : Text(
                    "Available Balance",
                    style : design.text_style.text_style2,
                  ), 
                ),

                const Flexible (
                  flex : 0, 
                  fit : FlexFit.loose,
                  child :SizedBox(height: 5),
                ),       

                Align(
                  alignment: Alignment.topLeft,
                  child : Text(
                    "$peso_sign $Balance",
                    style : design.text_style.text_style3,
                  ), 
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

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Flexible(
              child : Column(
                children: [
                  IconButton(
                    onPressed: () async => showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        actions : [
                          TextButton(
                            onPressed: (){
                              DB.cash_funds_db fund = DB.cash_funds_db();
                              double amount = double.tryParse(deposit.text) as double;  
                              fund.deposit_fund(user_id, amount);
                              print(user_id);
                              Navigator.pop(context, true);
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: ((context) => Landing(user_id: user_id,))));  
                              
                            }, 
                            child: Text("Confirm"))
                        ], 

                        title : Text("Amount"), 
                        contentPadding: EdgeInsets.all(20.0),
                        content : TextFormField(
                          controller: deposit,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        )

                      )
                    ), 
                    icon: Icon(Icons.arrow_upward_rounded),
                    color: design.custom_color.c_orange,
                    ), 
                    Text("Deposit")
                ],
              ),
            ),

            Flexible(
              child : SizedBox(
                width : 20.0
                )
            ),
            Flexible(
              child : Column(
                children: [
                  IconButton(
                    onPressed: () async => showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        actions : [
                          TextButton(
                            onPressed: (){
                              DB.cash_funds_db fund = DB.cash_funds_db();
                              double amount = double.tryParse(deposit.text) as double;  
                              fund.withdraw_fund(user_id, amount);
                              Navigator.pop(context, true);
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: ((context) => Landing(user_id: user_id,))));  
                            }, 
                            child: Text("Confirm"))
                        ], 

                        title : Text("Amount"), 
                        contentPadding: EdgeInsets.all(20.0),
                        content : TextField(
                          controller: deposit,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        )

                      )
                    ), 
                    icon: Icon(Icons.arrow_downward_rounded),
                    color: design.custom_color.c_orange,
                    ), 
                    Text("Withdraw")
                ],
              ),
            ),

            Flexible(
              child : SizedBox(
                width : 20.0
                )
            ),
            Flexible(
              child : Column(
                children: [
                  IconButton(
                    onPressed: () async => showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        actions : [
                          TextButton(
                            onPressed: null, 
                            child: Text("Confirm"))
                        ], 

                        title : Text("Amount"), 
                        contentPadding: EdgeInsets.all(20.0),
                        content : TextField(
                        )
                      )
                    ), 
                    icon: Icon(Icons.account_balance_rounded),
                    color: design.custom_color.c_orange,
                    ), 
                    Text("Send")
                ],
              ),
            ),
            

          ],
        )


      ],

    );
  }
}