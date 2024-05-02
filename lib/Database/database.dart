import 'package:cloud_firestore/cloud_firestore.dart';

class user_db{

  // initialize table
  final CollectionReference User = FirebaseFirestore.instance.collection("User"); 

  // adds a user to the table 
  Future<dynamic> add_user( String username, String email, String password ) async {
    QuerySnapshot snapshot = await User.orderBy('user_id', descending: true).limit(1).get();

    int id = snapshot.docs.first['user_id'];
    id += 1; 
    return User.add({
      'user_id' : id, 
      'Username' : username, 
      'Email' : email, 
      'Password' : password,
    });
  }

  Future username_exist(String username) async {
    QuerySnapshot snapshot = await User.where("Username", isEqualTo: username).get();
    if (snapshot.docs.isNotEmpty) {
      print ("ttrue");
      return true;
      
    }
    else {
      print ("ffalse");
      return false; 
      
    } 
  }

  Future email_exist(String email) async {
    QuerySnapshot snapshot = await User.where("Email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      print ("ttrue");
      return true;
    }
    else {
      print ("ffalse");
      return false; 
    } 
  }

  Future account_match(String username, String password) async {
    QuerySnapshot snapshot = await User.where("Username", isEqualTo: username).where("Password", isEqualTo: password).get();
    if (snapshot.docs.isNotEmpty) {
      print ("1true");
      
      return true;
    }
    else {
      print ("1false");
      return false; 
    } 
  }

  Future<int> get_ID(String username, String password) async {
    QuerySnapshot snapshot = await User.where("Username", isEqualTo: username)
      .where("Password", isEqualTo: password)
      .get();
    int user_id = snapshot.docs.first["user_id"]; 
    return user_id; 
  }

}

class cash_funds_db {
  final CollectionReference Cash_funds = FirebaseFirestore.instance.collection("Cash_funds");

  Future <Map> get_fund(int user_id) async {
    QuerySnapshot snapshot = await Cash_funds.where("User_id", isEqualTo: user_id).get();
    
    if(snapshot.docs.isEmpty){
      return {}; 
    }
    
    else {
      return snapshot.docs.first.data() as Map; 
    }

  }

  Future create_fund(int user_id) async {
    await Cash_funds.add({
      "User_id" : user_id, 
      "Years" : 0, 
      "Net_contribution" : 0.00
    });

    QuerySnapshot snapshot = await Cash_funds.where("User_id", isEqualTo: user_id).get();

    return snapshot.docs.first.data(); 

  }


  Future deposit_fund(int user_id, double amount)async {
    QuerySnapshot snapshot = await Cash_funds.where("User_id", isEqualTo: user_id).get();
    
    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      double balance = snapshot.docs.first["Net_contribution"];
      double new_balance = balance + amount; 

      return Cash_funds.doc(doc_id).update({
        "Net_contribution" : new_balance
      }); 
      
    }else {
      print("Cash Fund not found");
      return null; 
    }
    
  }

  Future withdraw_fund(int user_id, double amount)async {
    QuerySnapshot snapshot = await Cash_funds.where("User_id", isEqualTo: user_id).get();
    
    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      double balance = snapshot.docs.first["Net_contribution"];
      double new_balance = balance - amount; 

      return Cash_funds.doc(doc_id).update({
        "Net_contribution" : new_balance
      }); 
      
    }else {
      print("Cash Fund not found");
      return null; 
    }
    
  }

  Future send_fund(int user_id, int send_id, double amount)async {
    await withdraw_fund(user_id, amount); 
    await deposit_fund(send_id, amount); 
  }

  Future add_year(int user_id) async {
    QuerySnapshot snapshot = await Cash_funds.where("User_id", isEqualTo: user_id).get();

    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      int year = snapshot.docs.first["Years"];
      int new_year = year + 1; 

      return Cash_funds.doc(doc_id).update({
        "Years" : new_year
      }); 
      
    }else {
      print("Cash Fund not found");
      return null; 
    }
  }

  // TODO : Savings Matured 
  
  
}



class loan_funds_db{
  final CollectionReference Loan_funds = FirebaseFirestore.instance.collection("Loan_funds");

  // Housing Loan, Monthly Interest rate
  //  6 = 9%
  //  9 = 10% 
  //  12 = 11
  //  15 - 12 %
  //  1 M - 5 M 

  Map <String, double> calculate_interest(double initial_amount, double interest_rate, int term_duration){

    double total_loan = initial_amount; 
    double interest = 0; 

    for(int i = 0; i < term_duration; i++){
      interest += total_loan * interest_rate;
      total_loan = total_loan + interest; 
    }

    Map <String, double> loan_info = {
      "total_loan" : total_loan, 
      "interest" : interest
    };
    return loan_info; 
  }
  
  Future housing_loan(int user_id, double loan_amount, double interest_rate, int term_duration) async {
    QuerySnapshot snapshot = await Loan_funds.orderBy('housing_loan_id', descending: true).limit(1).get();

    int id = snapshot.docs.first['housing_loan_id'];
    id = 0;

    Map loan_info = calculate_interest(loan_amount, interest_rate, term_duration); 

    double interest = loan_info["interest"]; 
    double outstanding_balance = loan_info["total_loan"]; 

    String loan_name = "Housing Loan"; 
    DateTime datestart = DateTime.now(); 
    DateTime dateEnd = DateTime.now().add(Duration(days : term_duration * 360));  

    return Loan_funds.add({
      "User_id" : user_id, 
      "Loan_id" : id,
      "Loan_Name" : loan_name,
      "Date_start" : datestart,
      "Date_end" : dateEnd,  
      "Initial_amount" : loan_amount, 
      "Term_duration" : term_duration, 
      "Interest_rate" : interest_rate,  
      "Interest" : interest,  
      "Outstanding_balance" : outstanding_balance,
      "Loan_status" : "ongoing"
    });
  }

  Future <Map> get_loan_info(int user_id) async{
    try{
      QuerySnapshot snapshot = await Loan_funds.where("User_id", isEqualTo: user_id)
      .where("Outstanding_balance", isGreaterThan: 0).limit(1).get(); 

    if(snapshot.docs.isEmpty){
      print("yea");
      return {}; 
    }
    else{
      print("yeahh");
      return snapshot.docs.first.data() as Map;

    }

  }
  catch(e){
    print("Error fetching loan information: $e");
    throw e;
  }
    

  }

  

  

 
}