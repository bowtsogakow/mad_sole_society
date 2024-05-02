
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/Pages/Design.dart' as design;
import 'package:sole_society/Pages/Balance.dart' as balance;
import 'package:sole_society/Database/database.dart' as DB;
import 'package:sole_society/Pages/Init_loan.dart' as init_loan; 

class Landing extends StatefulWidget {
  const Landing({super.key, required this.user_id, });
  final int user_id ;

  @override
  State<Landing> createState() => Landing_State(user_id);
}

class Landing_State extends State<Landing>{

  Landing_State(this.user_id);


  int user_id = -1; 
  Map ? fund_data = {};

  DB.cash_funds_db fund = DB.cash_funds_db();   
  DB.loan_funds_db loan = DB.loan_funds_db(); 

 
  
  
  
   
  

  int currentPageIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
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
            print(index); 
            //print(fund_data["Years"]);
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
      body : <Widget>[
        
        Center(
          child: FutureBuilder(
            future: fund.get_fund(user_id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("meron");
                Map fundInfo = snapshot.data as Map;
                if (fundInfo != null && fundInfo.isNotEmpty) {
                  // If fund data exists, show the balance
                  
                  return balance.balance(fund: fundInfo);
                } else {
                  // If fund data doesn't exist, create fund and show balance
                  print("wala");
                  return FutureBuilder(
                    future: fund.create_fund(user_id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          Map newFundInfo = snapshot.data as Map;
                          return balance.balance(fund: newFundInfo);
                        } else {
                          return Text("0");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                }
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
            builder : (context, snapshot){
              if(snapshot.hasData){
                Map ? loan_info = snapshot.data as Map?;

                if (loan_info == null && loan_info!.isEmpty) {
                  print("10");
                  return Text("1"); 
                  
                }
                else {
                  return init_loan.init_loan();
                }
                
              
              }
              else{
                return CircularProgressIndicator(); 
              }
            }, 
          ),
        ), 

        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        )
      ][currentPageIndex], 

       
    );

  }
}