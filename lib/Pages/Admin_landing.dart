
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Pages/Account_approval.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Loan_Approval.dart';
import 'package:sole_society/Pages/Opening.dart';
import 'package:sole_society/Pages/Profile.dart' as profile;

class Admin_landing extends StatefulWidget {
  const Admin_landing({super.key, required this.user_id, required this.index});
  final int user_id ;
  final int index; 

  @override
  State<Admin_landing> createState() => Admin_Landing_State(user_id, index);
}

class Admin_Landing_State extends State<Admin_landing>{

  Admin_Landing_State(this.user_id, this.index);

  final int user_id;  
  final int index; 
  
  Map ? fund_data = {};

  DB.cash_funds_db fund = DB.cash_funds_db();   
  DB.loan_funds_db loan = DB.loan_funds_db(); 
  DB.user_db my_user = DB.user_db();

  int currentPageIndex = 0;
  
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPageIndex = index; 
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
                        label: 'Account Approval',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(Icons.credit_card_sharp),
                        icon: Icon(Icons.credit_card_off_outlined),
                        
                        label: 'Loan Approval',
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
                        child: StreamBuilder(
                          stream: my_user.get_waiting_account(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List accounts = snapshot.data as List; 
                              return account_approval(accounts: accounts);
                            } else {
                              // If snapshot doesn't have data, show loading indicator
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                      
                      Center(
                        child: StreamBuilder(
                          stream : loan.get_waiting_loan(),
                          builder : (context, snapshot2){
                            if(snapshot2.hasData){
                              List loan_waiting = snapshot2.data as List;
                    
                              return loan_approval(loan: loan_waiting);
                            }
                            else{
                    
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