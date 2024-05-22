// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/Receipt.dart' as receipt_widget; 
import 'package:sole_society/Pages/Signup.dart';

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
  String peso_sign = design.Peso.symbol; 
  TextEditingController deposit = TextEditingController();
  TextEditingController send = TextEditingController();
  TextEditingController withdraw = TextEditingController();
  TextEditingController email = TextEditingController();

  String errorSend = ""; 
  String errorEmail = ""; 
  String errorWithdraw = ""; 

  DB.cash_funds_db fund = DB.cash_funds_db();
  DB.receipt receipt = DB.receipt(); 

  bool loading = false; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user_id = fund_info["User_id"] as int; 
    if(fund_info["Net_contribution"] == null){
      Navigator.pop(context, true);
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => Landing(user_id:user_id, index : 0))
      );
    }else {
      Balance = fund_info["Net_contribution"].toDouble();
    }   

  }

  String checkAmount(double amount1, double amount2){
    if(amount1 < amount2){
      return "Not enough balance"; 
    }
    else{
      return ""; 
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(

      
      children: [
        loading ? CircularProgressIndicator() : 
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
                    "PHP ${Balance.toStringAsFixed(2)}",
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
                        backgroundColor: design.custom_color.c_offwhite,
                        actions : [
                          TextButton(
                            onPressed: () async {
                              double amount = double.tryParse(deposit.text) as double;  
                              String transaction = "Deposit Savings"; 
                              await fund.deposit_fund(user_id, amount);
                              await receipt.add_recepit(user_id, transaction, amount); 
                              Navigator.pop(context, true); 
                  
                              showDialog(
                                context: context, 
                                builder: (context) => AlertDialog(
                                  actions : [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context, true);
                                        Navigator.pop(context, true);
                                       
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: ((context) => Landing(user_id: user_id, index: 0,))));  
                                      
                                      }, 
                                      child: Text("Proceed", 
                                      style : design.text_style.text_style9)
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
                            child: Text("Confirm"))
                        ], 

                        title : Text("Amount"), 
                        contentPadding: EdgeInsets.all(20.0),
                        content : TextFormField(
                          controller: deposit,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          labelText: 'Amount', // Placeholder text
                          labelStyle: design.text_style.text_style1,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          focusedErrorBorder: design.input_border.focus,
                          errorBorder: design.input_border.error,
                          enabledBorder: design.input_border.enabled,
                          focusedBorder: design.input_border.focus
                          ),
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
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: design.custom_color.c_offwhite,
                            actions : [
                              TextButton(
                                onPressed: () async {
                                  
                                  double amount = double.tryParse(withdraw.text) as double;
                                  
                                  setState(() {                         
                                    errorWithdraw = checkAmount(Balance, amount);
                                  });
                                  
                                  if(errorWithdraw == ""){
                          
                                    String transaction = "Withdraw Savings"; 
                                    await fund.withdraw_fund(user_id, amount);
                                    await receipt.add_recepit(user_id, transaction, amount); 
                                    
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
                                              MaterialPageRoute(builder: ((context) => Landing(user_id: user_id, index : 0))));  
                                            
                                            }, 
                                            child: Text("Proceed", 
                                            style : design.text_style.text_style9)
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
                          
                                  }
                          
                                  
                                  }, 
                                child: Text("Confirm"))
                            ], 
                          
                            title : Text("Amount"), 
                            contentPadding: EdgeInsets.all(20.0),
                            content : TextFormField(
                              controller: withdraw,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              errorText: errorWithdraw,
                              errorStyle: TextStyle(height: 0.1, fontSize: 10),
                              errorMaxLines: 1,
                              labelText: 'Amount', // Placeholder text
                              labelStyle: design.text_style.text_style1,
                              contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              focusedErrorBorder: design.input_border.focus,
                              errorBorder: design.input_border.error,
                              enabledBorder: design.input_border.enabled,
                              focusedBorder: design.input_border.focus,
                              ), 
                            )
                          
                          );
                        }
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
                    onPressed: () async { 
                      showDialog(
                      context: context, 
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            actions : [
                              TextButton(
                                onPressed: () async {
                                   
                                  authentication_methods auth = authentication_methods(); 
                                  DB.user_db user = DB.user_db();
                                  double amount2 = 0.0;
                                  
                                  setState(() {
                                    errorEmail = auth.validate_email(email.text) as String; 
                                    if(send.text == ""){
                                      errorSend = "Please Enter an amount";
                                    }
                                    else{
                                      amount2 = double.tryParse(send.text) as double;                                
                                      errorSend = checkAmount(Balance, amount2);
                                      
                                    }                                   
                                  });



                                  if(errorSend == "" && errorEmail == ""){
                                    bool status = await user.email_exist(email.text) as bool; 
                                    
                                    
                                    if(status == true){
                                      int user_id_send = await user.getIDbyEmail(email.text) as int; 
                                      await fund.send_fund(user_id, user_id_send, amount2); 
                                      String transaction = "Send Money";
                                      String transaction2 = "Receive Money"; 
                                      await receipt.add_recepit(user_id, transaction, amount2); 
                                      await receipt.add_recepit(user_id_send, transaction2, amount2); 


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
                                                MaterialPageRoute(builder: ((context) => Landing(user_id: user_id, index : 0))));  
                                              
                                              }, 
                                              child: Text("Proceed", 
                                              style : design.text_style.text_style9)
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

                                    }
                                    else{
                                      setState((){
                                        loading = false; 
                                        errorEmail = "Email does not exist";
                                      });
                                    }
                                  }
                                   
                          
                                }, 
                                child: Text("Confirm"))
                            ], 
                          
                            title : Text("Amount"), 
                            contentPadding: EdgeInsets.all(20.0),
                            content : SizedBox(
                              height: 150, 
                              width : 200,
                              child: Column(
                                children: [
                                  
                                  TextFormField(
                                    controller: email,
                                     decoration : InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
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
                          
                                  SizedBox(
                                    height: 20,
                                  ),
                              
                                  TextFormField(
                                    controller: send,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                     decoration : InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      errorText: errorSend,
                                      errorStyle: TextStyle(height: 0.1, fontSize: 10),
                                      errorMaxLines: 1,
                                      labelText: 'Amount', // Placeholder text
                                      labelStyle: design.text_style.text_style1,
                                      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                      focusedErrorBorder: design.input_border.focus,
                                      errorBorder: design.input_border.error,
                                      enabledBorder: design.input_border.enabled,
                                      focusedBorder: design.input_border.focus,
                                      ), 
                                  ), 
                              
                                ],
                              ),
                            )
                            
                            
                          );
                        }
                      )
                    
                    );}, 
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