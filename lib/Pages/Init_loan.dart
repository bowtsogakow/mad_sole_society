// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/Loan_history.dart';

class init_loan extends StatefulWidget {
  const init_loan({super.key, required this.user_id});

  final int user_id; 

  @override
  State<init_loan> createState() => init_loan_state(user_id);
}

class init_loan_state extends State<init_loan> {
  
  init_loan_state(this.user_id); 

  int user_id; 
  
  String loan_type = "";
  TextEditingController? loan_amount = TextEditingController();
  double interest_rate = 0.0; 
  String term_duration = "";
  double interest_interval = 0.0;     
  double interest = 0.0; 
  double total_loan = 0.0; 

  DB.loan_funds_db loan = DB.loan_funds_db();


  String? validateLoanAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a loan amount.';
    }
    double amount = double.parse(value).toDouble();
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

  void setLoanNull(){
    loan_type = ""; 
    loan_amount!.text = ""; 
    interest_rate = 0; 
    term_duration = ""; 
    interest_interval = 0; 
    interest = 0;
    total_loan = 0; 
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
                      "PHP 0",
                      style : design.text_style.text_style3,
                    ), 
                  ),

                ],
              )
              
            ),  
          ), 

          const Flexible (
          flex : 1, 
          fit : FlexFit.loose,
          child :SizedBox(height: 140),
          ),  
          
          Text("There are no active loans"),

          const Flexible (
          flex : 1, 
          fit : FlexFit.loose,
          child :SizedBox(height: 140),
          ),  

          Flexible(
              flex : 0, 
              fit : FlexFit.tight,
              child : SizedBox(
                height: 30,
                width: 200,
                child : ElevatedButton(
              
                  onPressed: () async {                    
                    setLoanNull(); 
                    showDialog(context: context, 
                      builder: (context) => AlertDialog(
                        actions :  [
                          TextButton(
                          onPressed: (){
                            if(loan_type.isEmpty){
                              Navigator.pop(context); 
                            }
                            else{
                              Navigator.pop(context);
                              showDialog(context: context, 
                                builder: (context) => AlertDialog(
                                  actions : [
                                    TextButton(
                                      onPressed: (){
                                        if (loan_type.isEmpty) {
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
                                            actions : [
                                              TextButton(
                                                onPressed: (){
                                                  double initial_amount = double.parse(loan_amount!.text).toDouble();
                                                  Map interest_info = loan.calculate_interest(initial_amount, interest_rate, interest_interval);

                                                  interest = interest_info["interest"];
                                                  total_loan = interest_info["total_loan"];

                                                  Navigator.pop(context, true);
                                                  showDialog(
                                                    context: context, 
                                                    builder: (context) => AlertDialog(
                                                      actions : [
                                                        TextButton(
                                                          onPressed: ()async {
                                                            await loan.make_loan(user_id, loan_type, initial_amount, interest_rate, term_duration, interest, total_loan);
                                                            Navigator.pop(context, true); 

                                                            Navigator.pop(context, true); 
                                                            Navigator.push(
                                                              context, 
                                                              MaterialPageRoute(builder: (context) => Landing(user_id:user_id, index : 1)),);
                                                            
                                                          }, 
                                                          child: Text("Confirm",
                                                          style: design.text_style.text_style9,
                                                          ))
                                                      ],
                                                      title : Text("Loan Summary", 
                                                      style : design.text_style.text_style7),
                                                      contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                                                      content : SizedBox(
                                                        height: 210,
                                                        width : 250, 
                                                        child : display_loan_info(
                                                          loan_type : loan_type ,
                                                          initial_amount : initial_amount,
                                                          interest_rate : interest_rate,
                                                          term_duration : term_duration,
                                                          interest_interval : interest_interval,
                                                          interest : interest,
                                                          total_loan : total_loan),  
                                                      )
                                                    ) 
                                                    ); 
                                                  
                                             

                                                }, 
                                                child: Text("Confirm", 
                                                style: design.text_style.text_style9,
                                                )),

                                            ], 
                                            title : Text("Choose Loan Duration", 
                                            style : design.text_style.text_style7),
                                            contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                                            content : SizedBox(
                                              height: 200,
                                              width : 350, 
                                              child : duration(
                                                onIntervalChanged: (selectedValue){
                                                  setState(() {
                                                    interest_interval = selectedValue.toDouble();
                                                  });
                                                },
                                                onInterestChanged: (selectedValue){
                                                  setState(() {
                                                    interest_rate = selectedValue.toDouble();  
                                                  });
                                                },
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
                                      child: Text("Confirm",
                                      style: design.text_style.text_style9,
                                      )
                                      )
                                  ], 
                                  title : Text("Enter Amount", 
                                  style : design.text_style.text_style7),
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
                          child : Text("Confirm", 
                          style: design.text_style.text_style9,
                          )
                          ),
                        ],
                        title : Text("Choose Loan Type",
                        style : design.text_style.text_style7),
                        contentPadding: EdgeInsets.symmetric(horizontal : 10, vertical : 20,),
                        content : SizedBox(
                          height: 200,
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

          const Flexible (
            flex : 0, 
            fit : FlexFit.loose,
            child :SizedBox(height: 30),
            ),  

          SizedBox(
            height: 30,
            width: 200,
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
  List loan_description = [
    "Loanable amount is from 5,000 pesos up to 50,000 pesos",
    "Loanable amount is from 50,000 pesos up to 500,000 pesos",
    "Loanable amount is from 500,000 pesos up to 5,000,000 pesos",

  ]; 

  String description = ""; 
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
                        description = loan_description[2];
                        widget.onGroupValueChanged(GroupValue!);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Housing Loan", 
                  style : design.text_style.text_style1), 
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
                        description = loan_description[1];
                        widget.onGroupValueChanged(GroupValue!);
                      });
                    } ,
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Medium Loan", 
                  style : design.text_style.text_style1), 
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
                        description = loan_description[0];
                        widget.onGroupValueChanged(GroupValue!);
                      });
                    } ,
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text("Micro Loan", 
                  style : design.text_style.text_style1), 
                ]
              ),

              SizedBox(
                height: 10,
              ),

              Text(description) 
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
  const duration({super.key, required this.onGroupValueChanged, required this.loan_type, required this.onInterestChanged, required this.onIntervalChanged});

  final Function(String) onGroupValueChanged;
  final Function(double) onInterestChanged; 
  final Function(double) onIntervalChanged; 
  final String ? loan_type; 

  @override
  State<duration> createState() => _durationState(loan_type);
}

class _durationState extends State<duration> {

  _durationState(this.loan_type); 
  final String ? loan_type; 
  
  double Interest = 0.0;  
  String duration = ""; 
  double Interval = 0; 
  List loan_Options = [];
  List interest_Options = []; 
  List interval_Options = []; 
  List text_interval = [];

  void setTermChoices(String ? choices){

    if(choices == "Housing Loan"){
      loan_Options = ["3 years", "6 years", "9 years", "12 years"]; 
      interest_Options = [0.09, 0.10, 0.11, 0.12];
      interval_Options = [3, 6, 9, 12];
      text_interval = [" (9% / year)", " (10% / year)", " (11% / year)", " (12% / year)"];
    }
    else if(choices == "Medium Loan"){
      loan_Options = ["6 months ", "12 months", 
      "18 months ", "24 months"];
      interest_Options = [0.05, 0.05, 0.06, 0.06];
      interval_Options = [1, 2, 3, 4]; 
      text_interval = [" (5% / 6 months)", " (5% / 6 months)", " (6% / 6 months)", " (6% / 6 months)"];
    }
    else if(choices == "Micro Loan"){
      loan_Options = ["8 weeks", "12 weeks", 
      "16 weeks", "20 weeks"];
      interest_Options = [0.04, 0.04, 0.04, 0.04];
      interval_Options = [2, 3, 4, 5];
      text_interval = [ " (4% / 4 weeks)", " (4% / 4 weeks)", " (4% / 4 weeks)", " (4% / 4 weeks)"];
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
                    value: loan_Options[0],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        Interest = interest_Options[0].toDouble();
                        duration = value; 
                        Interval = interval_Options[0].toDouble();
                        widget.onIntervalChanged(Interval); 
                        widget.onInterestChanged(Interest); 
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(loan_Options[0], 
                  style : design.text_style.text_style6,
                  ), 

                  SizedBox(
                    width: 10.0,
                  ), 
                  
                  Text(text_interval[0], 
                  style : design.text_style.text_style6,
                  ), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: loan_Options[1],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        Interest = interest_Options[1].toDouble();
                        duration = value; 
                        Interval = interval_Options[1].toDouble();
                        widget.onIntervalChanged(Interval);
                        widget.onInterestChanged(Interest);
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(loan_Options[1], 
                  style : design.text_style.text_style6,
                  ), 

                  SizedBox(
                    width: 10.0,
                  ), 
                  
                  Text(text_interval[1], 
                  style : design.text_style.text_style6,
                  ), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: loan_Options[2],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        Interest = interest_Options[2].toDouble();
                        duration = value; 
                        Interval = interval_Options[2].toDouble();
                        widget.onIntervalChanged(Interval);
                        widget.onInterestChanged(Interest);
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(loan_Options[2], 
                  style : design.text_style.text_style6,
                  ), 

                  SizedBox(
                    width: 10.0,
                  ), 
                  
                  Text(text_interval[2], 
                  style : design.text_style.text_style6,
                  ), 
                ]
              ),

              Row( 
                children : [
                
                  Radio(
                    value: loan_Options[3],
                    activeColor: design.custom_color.c_orange,
                    groupValue: duration,
                    onChanged: (value) {
                      setState(() {
                        duration = value;
                        Interest = interest_Options[3].toDouble();
                        Interval = interval_Options[3].toDouble();
                        widget.onIntervalChanged(Interval); 
                        widget.onInterestChanged(Interest);
                        widget.onGroupValueChanged(duration);
                      });
                      
                    } ,
                    
                  ),

                  SizedBox(
                    width: 5.0,
                  ), 

                  Text(loan_Options[3], 
                  style : design.text_style.text_style6,), 

                  SizedBox(
                    width: 10.0,
                  ), 
                  
                  Text(text_interval[3], 
                  style : design.text_style.text_style6,
                  ), 
                ]
              ),

            ],
          );
  }
}


class display_loan_info extends StatefulWidget {
  const display_loan_info({super.key, 
    required this.loan_type, 
    required this.initial_amount, 
    required this.interest_rate, 
    required this.term_duration, 
    required this.interest_interval, 
    required this.interest, 
    required this.total_loan});

  final String loan_type; 
  final double initial_amount;
  final double interest_rate; 
  final String term_duration; 
  final double interest_interval; 
  final double interest;
  final double total_loan; 

  @override
  State<display_loan_info> createState() => _display_loan_infoState(loan_type, initial_amount, interest_rate, term_duration, interest_interval, interest, total_loan);
}

class _display_loan_infoState extends State<display_loan_info> {

  _display_loan_infoState(this.loan_type, this.initial_amount, this.interest_rate, this.term_duration, this.increase_interval, this.interest, this.total_loan_amount); 

  final String loan_type; 
  final double initial_amount;
  final double interest_rate; 
  final String term_duration; 
  final double increase_interval; 
  final double interest;
  final double total_loan_amount;  

  String TextInterval = ""; 
  
  void setTextInterval(choices){
    if(choices == "Housing Loan"){
      TextInterval = "Every Year";
    }
    else if(choices == "Medium Loan"){
      TextInterval = "Every 6 months";
      }
    else if(choices == "Micro Loan"){
      TextInterval = "Every 4 weeks";  
    }
  } 

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTextInterval(loan_type); 
  }
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child : Column(
        children : [
          Row(
            children: [
              Text("Loan Type : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("$loan_type", style : design.text_style.text_style6,),
            ],        
          ), 

          SizedBox(
            height: 10,
          ), 

          Row(
            children: [
              Text("Initial Loan : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("$initial_amount", style : design.text_style.text_style6,),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Text("Interest Rate : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("$interest_rate", style : design.text_style.text_style6,),
            ],
          ),

          SizedBox(
            height: 10,
          ), 

          Row(
            children: [
              Text("Loan Duration : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("$term_duration", style : design.text_style.text_style6,),
            ],
          ), 

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Text("Interest Interval : ", style : design.text_style.text_style6,),
              Spacer(),
              Text(TextInterval, style : design.text_style.text_style6,),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Text("Interest : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("PHP ${interest.toStringAsFixed(2)}", style : design.text_style.text_style6,),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              Text("Total Loan : ", style : design.text_style.text_style6,),
              Spacer(),
              Text("PHP ${total_loan_amount.toStringAsFixed(2)}", style : design.text_style.text_style6,),
            ],
          )




        ],
      ),
    );

  }
}