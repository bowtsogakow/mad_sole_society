
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Pages/Balance.dart' as balance;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Init_loan.dart' as init_loan; 
import 'package:sole_society/Pages/Loan.dart' as LOAN;
import 'package:sole_society/Pages/Loan_history.dart';
import 'package:sole_society/Pages/Transaction.dart'; 
import 'package:sole_society/Pages/Profile.dart' as profile;

class Landing extends StatefulWidget {
  const Landing({super.key, required this.user_id, required this.index});
  final int user_id ;
  final int index; 

  @override
  State<Landing> createState() => Landing_State(user_id, index);
}

class Landing_State extends State<Landing>{

  Landing_State(this.user_id, this.index1);

  final int user_id;  
  final int index1;

  Map ? fund_data = {};

  DB.cash_funds_db fund = DB.cash_funds_db();   
  DB.loan_funds_db loan = DB.loan_funds_db(); 
  DB.receipt receipt = DB.receipt();
  DB.user_db my_user = DB.user_db();

  int currentPageIndex = 0;

    void initState() {
    // TODO: implement initState
    super.initState();
    currentPageIndex = index1;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child : ConstrainedBox(
                constraints: constraints.copyWith(
                  maxHeight: constraints.maxHeight
                ),
                child : Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: design.custom_color.c_offwhite,
                  appBar : AppBar(
                    backgroundColor: design.custom_color.c_offwhite,
                    title: const Text("Cash Up",
                    style: design.text_style.text_style1,
                    ),
                        
                  ),

                  bottomNavigationBar: NavigationBar(
                    backgroundColor: design.custom_color.c_offwhite,
                    onDestinationSelected: (int index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                      
                    },
                    selectedIndex: currentPageIndex,
                    destinations: const <Widget>[
                      NavigationDestination(
                        
                        icon: Icon(Icons.account_balance_wallet_outlined),
                        selectedIcon: Icon(Icons.account_balance_wallet_sharp),            
                        label: 'Balance',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(Icons.credit_card_sharp),
                        icon: Icon(Icons.credit_card_off_outlined),
                        
                        label: 'Credit',
                      ),
                      NavigationDestination( // Gamitin yung badge class if gagamitin mo yung number chuchu
                        selectedIcon: Icon(Icons.receipt_sharp),
                        icon: Icon(Icons.receipt_outlined),
                        label: 'Transactions',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(Icons.person_sharp),
                        icon: Icon(Icons.person_outline),  
                        
                        label: 'Profile',
                      ),
                    ],
                  ),
                  body : IndexedStack(

                    index: currentPageIndex,
                    children : <Widget>[
                      
                      Center(
                        child: FutureBuilder(
                          future: fund.get_fund(user_id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              
                              return balance.balance(fund: snapshot.data as Map);
                            } else {
                              // If snapshot doesn't have data, show loading indicator
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      
                      Center(
                        child: FutureBuilder(
                          future : loan.get_loan_info(user_id),
                          builder : (context, snapshot2){
                            if(snapshot2.hasData){
                              Map loan_info = {}; 
                              loan_info = snapshot2.data as Map;

                              if(loan_info.isNotEmpty){
                                if(loan_info["Approval_status"] == "Approved"){
                                  return LOAN.loan(loan_info: loan_info);
                                }
                                else {
                                  return Center(
                                    child : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children : [
                                        
                                        Spacer(), 
                                        Spacer(),

                                        const Text(
                                          "Loan Application is waiting for approval", 
                                          style : design.text_style.text_style1,
                                        ),

                                        Spacer(),
                                        Spacer(), 

                                        SizedBox(
                                          height: 40,
                                          width: 250,
                                          child : ElevatedButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: ((context) => loan_history(user_id: user_id,))));  
                                                
                                            },
                                            child: const Text( // ignore: sort_child_properties_last
                                              'VIEW PAST LOANS',
                                              style: design.text_style.text_style2, // Set text color,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: design.custom_color.c_orange, // Set button color
                                              // backgroundColor: Colors.orange,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
                                            ),   
                                          ),
                                        ), 

                                        Spacer(), 

                                      ]
                                    )
                                  );
                                }
                                
                              }
                              else{
                                return init_loan.init_loan(user_id: user_id);
                              }
                            }
                            else{
                              return CircularProgressIndicator(); 
                            }
                          }, 
                        ),
                      ), 

                      Center(
                        child: FutureBuilder(
                          future : receipt.get_history(user_id),
                          builder : (context, snapshot){
                            if(snapshot.hasData){
                              List history = []; 
                              history = snapshot.data as List;

                              if(history.isNotEmpty){
                                return transaction(history: history,); 
                              }
                              else{
                                return Text("You have not yet made your first transaction!");
                              }
                            }
                            else{
                              print("$snapshot"); 
                              return CircularProgressIndicator(); 
                            }
                          }, 
                        ),
                      ), 


                      Center(
                        child : FutureBuilder(
                          future: my_user.get_user_info(user_id), 
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              Map user_info = snapshot.data; 
                              return profile.profile(user_info : user_info);  
                            }
                            else{
                              return CircularProgressIndicator(); 
                            }

                          }
                          ),
                      )
                    ] 
                  )
                    
                ), 
              )
            );
          }
    );

  }
}