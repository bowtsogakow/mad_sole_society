// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;

class init_loan extends StatefulWidget {
  const init_loan({super.key});

  @override
  State<init_loan> createState() => init_loan_state();
}

class init_loan_state extends State<init_loan> {
  
  
  String ? loan_type = "";
  TextEditingController? loan_amount = TextEditingController(); 
  String ? term_duration = ""; 


  String? validateLoanAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a loan amount.';
    }
    double amount = double.parse(value);
    switch (loan_type) {
      case 'Micro Loan':
        if (amount < 5000 || amount > 50000) {
          return 'Loan amount for "Micro Loan" must be between ₱5,000 and ₱50,000.';
        }
        break;
      case 'Medium Loan':
        if (amount < 5001 || amount > 500000) {
          return 'Loan amount for "Medium Loan" must be between ₱5,001 and ₱500,000.';
        }
        break;
      case 'Housing Loan':
        if (amount < 500001 || amount > 5000000) {
          return 'Loan amount for "Housing Loan" must be between ₱500,001 and ₱5,000,000.';
        }
        break;
      default:
        return null; // Handle missing loan type selection
    }
    return null; 
      // No error, validation successful
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child : Column(
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
                      "Outstanding Loan",
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
                      "₱ 0",
                      style : design.text_style.text_style3,
                    ), 
                  ),

                ],
              )
              
            ),  
          ), 

          const Flexible (
          flex : 2, 
          fit : FlexFit.loose,
          child :SizedBox(height: 170),
          ),  
          
          Text("There are no active loans"),

          const Flexible (
          flex : 2, 
          fit : FlexFit.loose,
          child :SizedBox(height: 170),
          ),  

          Flexible(
              flex : 0, 
              fit : FlexFit.tight,
              child : SizedBox(
                height: 30,
                width: 200,
                child : ElevatedButton(
                  onPressed: () async {                    
                    
                    showDialog(context: context, 
                      builder: (context) => AlertDialog(
                        actions :  [
                          TextButton(
                          onPressed: (){
                            if(loan_type!.isEmpty){
                              Navigator.pop(context); 
                            }
                            else{
                              Navigator.pop(context);
                              showDialog(context: context, 
                                builder: (context) => AlertDialog(
                                  actions : [
                                    TextButton(
                                      onPressed: (){
                                        if (loan_type!.isEmpty) {
                                          Navigator.pop(context); // Close the first AlertDialog
                                          return; // Exit the function if no loan type selected
                                        }

                                        String? error = validateLoanAmount(loan_amount?.text); // Validate the loan amount

                                        if (error != null) {
                                          // Show an error message (e.g., using a SnackBar)
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(error)));
                                          return; // Exit the function if validation fails
                                        }
                                        else{
                                          Navigator.pop(context);
                                          showDialog(context: context, 
                                            builder: (context) => AlertDialog(
                                            
                                            title : Text("Enter Amount"),
                                            contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                                            content : SizedBox(
                                              height: 100,
                                              width : 250, 
                                              child : duration(
                                                loan_type: loan_type,
                                                onGroupValueChanged: (selectedValue){
                                                  setState(() {
                                                    term_duration = selectedValue; 
                                                  });
                                                },
                                              )
                                            )
                                            )
                                          );
                                        }

                                      }, 
                                      child: Text("Confirm")
                                      )
                                  ], 
                                  title : Text("Enter Amount"),
                                  contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                                  content : SizedBox(
                                    height: 100,
                                    width : 250, 
                                    child : TextFormField(
                                      validator: validateLoanAmount,
                                      controller: loan_amount,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    )
                                  ),
                                )
                              ); 
                            }
                          },
                          child : Text("Confirm")
                          ),
                        ],
                        title : Text("Choose Loan Type"),
                        contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                        content : SizedBox(
                          height: 150,
                          width : 250, 
                          child : loanTypeRadio(
                            onGroupValueChanged: (selectedValue){
                              setState(() {
                                loan_type = selectedValue; 
                              });
                            },
                          )
                                 
                        )
                      )
                    );

                  },                 
                  child: const Text( // ignore: sort_child_properties_last
                    'MAKE A LOAN',
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


        ],
      )
    );
  }
}


class loanTypeRadio extends StatefulWidget {
  const loanTypeRadio({super.key, required this.onGroupValueChanged});

  final Function(String) onGroupValueChanged;

  @override
  State<loanTypeRadio> createState() => _loanRadioState();
}

class _loanRadioState extends State<loanTypeRadio> {

  String ? GroupValue = ""; 
  @override
  Widget build(BuildContext context) {
    return Column(
            children : [
              Row( 
                children : [
                
                  Radio(
                    value: "Housing Loan",
                    activeColor: design.custom_color.c_orange,
                    groupValue: GroupValue,
                    onChanged: (value) {
                      setState(() {
                        GroupValue = value as String?; 
                        widget.onGroupValueChanged(GroupValue!);
                        print("1");
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Housing Loan"), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: "Medium Loan",
                    activeColor: design.custom_color.c_orange,
                    groupValue: GroupValue,
                    onChanged: (value) {
                      setState(() {
                        GroupValue = value as String?; 
                        widget.onGroupValueChanged(GroupValue!);
                        print("2");
                      });
                    } ,
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Medium Loan"), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: "Micro Loan",
                    activeColor: design.custom_color.c_orange,
                    groupValue: GroupValue,
                    onChanged: (value) {
                      setState(() {
                        GroupValue = value as String?; 
                        widget.onGroupValueChanged(GroupValue!);
                        print("3");
                        print(GroupValue);
                      });
                    } ,
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Micro Loan"), 
                ]
              ),

            ],
          );
  }
}


class loanAmount extends StatefulWidget {
  const loanAmount({super.key});


  @override
  State<loanAmount> createState() => _loanAmountState();
}

class _loanAmountState extends State<loanAmount> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class duration extends StatefulWidget {
  const duration({super.key, required this.onGroupValueChanged, required this.loan_type});

  final Function(String) onGroupValueChanged;
  final String ? loan_type; 

  @override
  State<duration> createState() => _durationState(loan_type);
}

class _durationState extends State<duration> {

  _durationState(this.loan_type); 
  final String ? loan_type; 

  String duration = ""; 
  List Options = [];

  void setTermChoices(String ? choices){

    if(choices == "Housing Loan"){
      Options = ["3 years", "6 years", "9 years", "12 years"]; 
    }
    else if(choices == "Medium Loan"){
      Options = ["6 months", "12 months", "18 months", "24 months"];
    }
    else if(choices == "Small Loan"){
      Options = ["8 weeks", "12 weeks", "16 weeks", "20 weeks"];
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTermChoices(loan_type); 
  }

   
  @override
  Widget build(BuildContext context) {
    return Column(
            children : [
              Row( 
                children : [
                
                  Radio(
                    value: Options[0],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value; 
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(Options[0]), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: Options[1],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value; 
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(Options[1]), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: Options[2],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value; 
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(Options[2]), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: Options[4],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value; 
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(Options[4]), 
                ]
              ),

            ],
          );
  }
}