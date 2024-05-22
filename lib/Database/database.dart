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
      "Approval_status" : "Waiting", 
    });
  }

  Future username_exist(String username) async {
    QuerySnapshot snapshot = await User.where("Username", isEqualTo: username).get();
    if (snapshot.docs.isNotEmpty) {
      return true;
      
    }
    else {
      return false; 
      
    } 
  }

  Future email_exist(String email) async {
    QuerySnapshot snapshot = await User.where("Email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return true;
    }
    else {
      return false; 
    } 
  }

  Future account_match(String username, String password) async {
    QuerySnapshot snapshot = await User.where("Username", isEqualTo: username)
      .where("Password", isEqualTo: password)
      .where("Approval_status", isEqualTo: "Approved").get();
    if (snapshot.docs.isNotEmpty) {
      return true;
    }
    else {
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

  Future get_user_info(int user_id) async {
    QuerySnapshot snapshot = await User.where("user_id", isEqualTo: user_id).get(); 

    if(snapshot.docs.isEmpty){
      return {}; 
    }
    else{
      return snapshot.docs.first.data() as Map; 
    }
  }

  Future change_password(int user_id, String password) async {
    QuerySnapshot snapshot = await User.where("user_id", isEqualTo: user_id).get();

    if(snapshot.docs.isEmpty){
      return ""; 
    }
    else{
      String doc_id = snapshot.docs.first.id; 

      return User.doc(doc_id).update({
        "Password" : password
      }); 
    }

  }

  Stream <List> get_waiting_account() async* {
    QuerySnapshot snapshot = await User.where("Approval_status" , isEqualTo: "Waiting").get();

    if(snapshot.docs.isEmpty){
      yield []; 
    }
    else {
      yield snapshot.docs; 
    }
  }

  Future approve_account(int user_id) async {
    QuerySnapshot snapshot = await User.where("user_id", isEqualTo: user_id)
    .where("Approval_status" , isEqualTo: "Waiting").get();

    if(snapshot.docs.isEmpty){
      return null; 
    }
    else{
      String doc_id = snapshot.docs.first.id; 

      return User.doc(doc_id).update({
        "Approval_status" : "Approved"
      }); 
    }

  }


  Future delete_account(int user_id) async {
    QuerySnapshot snapshot = await User.where("user_id", isEqualTo: user_id).get();

    if(snapshot.docs.isEmpty){
      return null; 
    }
    else{
      String doc_id = snapshot.docs.first.id; 

      return User.doc(doc_id).delete(); 
    }

  }

  Future getIDbyEmail(String email) async {
    QuerySnapshot snapshot = await User.where("Email", isEqualTo: email).get();

    if(snapshot.docs.isEmpty){
      return -1; 
    }
    else{
      return snapshot.docs.first["user_id"]; 
    }
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
      double balance = snapshot.docs.first["Net_contribution"].toDouble();
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
      double balance = snapshot.docs.first["Net_contribution"].toDouble();
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

  Map <String, double> calculate_interest(double initial_amount, double interest_rate, double interest_interval){

    double total_loan = initial_amount; 
    double interest = 0; 

    for(int i = 0; i < interest_interval; i++){
      interest += total_loan * interest_rate;
      total_loan = total_loan + interest; 
    }

    Map <String, double> loan_info = {
      "total_loan" : total_loan, 
      "interest" : interest
    };
    return loan_info; 
  }
  
  Future make_loan(int user_id, 
    String loan_type,
    double initial_amount, 
    double interest_rate,
    String term_duration,
    double interest, 
    double total_loan) async {

    QuerySnapshot snapshot = await Loan_funds.orderBy('Loan_id', descending: true).limit(1).get();

    int id = 0; 
    if(snapshot.docs.isEmpty){
      id = 0; 
    } else {
      id = snapshot.docs.first['Loan_id'];
      id +=1;
    }
    
     
    
    int dayz = convertToDays(term_duration); 
    DateTime datestart = DateTime.now(); 
    DateTime dateEnd = DateTime.now().add(Duration(days : dayz));  

    
    return Loan_funds.add({
      "User_id" : user_id, 
      "Loan_id" : id,
      "Loan_type" : loan_type,
      "Date_start" : datestart,
      "Date_end" : dateEnd,  
      "Date_payed" : "Loan is not yet fully paid",
      "Initial_amount" : initial_amount, 
      "Interest_rate" : interest_rate,  
      "Interest" : interest,
      "Total_loan" : total_loan , 
      "Outstanding_balance" : total_loan,
      "Approval_status" : "Waiting"
    });
  }

  Future <Map> get_loan_info(int user_id) async{
    try{
      QuerySnapshot snapshot = await Loan_funds.where("User_id", isEqualTo: user_id)
      .where("Outstanding_balance", isGreaterThan: 0).limit(1).get(); 

    if(snapshot.docs.isEmpty){
      return {}; 
    }
    else{
      return snapshot.docs.first.data() as Map;
    }

  }
  catch(e){
    print("Error fetching loan information: $e");
    throw e;
  }
    

  }

  Future <List> get_loan_history(int user_id) async{
    try{
      QuerySnapshot snapshot = await Loan_funds.where("User_id", isEqualTo: user_id)
      .orderBy("Date_start", descending: true).get(); 

    if(snapshot.docs.isEmpty){
      return []; 
    }
    else{
      return snapshot.docs;
    }

  }
  catch(e){
    print("Error fetching loan information: $e");
    throw e;
  }
    

  }

  Stream get_waiting_loan() async*{
    QuerySnapshot snapshot = await Loan_funds.where("Approval_status" , isEqualTo: "Waiting").get();
    user_db user = user_db(); 

    List results = [];
    
    if(snapshot.docs.isEmpty){
      yield []; 
    }
    else {

      for(int i = 0; i < snapshot.docs.length ; i++){

        int user_id = snapshot.docs[i]["User_id"] as int;
        QuerySnapshot snapshot_user = await user.User.where("user_id" , isEqualTo: user_id).get();

        results.add({
          "user_info" : snapshot_user.docs.first.data(), 
          "loan_info" : snapshot.docs[i].data(), 
        });

      }

      yield results; 
    }

  }

  Future approve_loan(int loan_id) async {
    QuerySnapshot snapshot = await Loan_funds.where("Loan_id" , isEqualTo: loan_id).get();

    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      return Loan_funds.doc(doc_id).update({
        "Approval_status" : "Approved"
      }); 
      
    }
    else {
      print("Cash Fund not found");
      return null; 
    }

  }

  Future delete_loan(int loan_id) async {
    QuerySnapshot snapshot = await Loan_funds.where("Loan_id" , isEqualTo: loan_id).get();

    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      return Loan_funds.doc(doc_id).delete(); 
      
    }
    else {
      print("Cash Fund not found");
      return null; 
    }

  }



  Future pay_loan(int loan_id, double amount) async{
    QuerySnapshot snapshot = await Loan_funds.where("Loan_id", isEqualTo: loan_id).get();
    
    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      double balance = snapshot.docs.first["Outstanding_balance"].toDouble();
      double new_balance = balance - amount; 
      print("$new_balance"); 
      return Loan_funds.doc(doc_id).update({
        "Outstanding_balance" : new_balance
      }); 
      
    }
    else {
      print("Cash Fund not found");
      return null; 
    }

  }

  Future setLoanInvalid(int loan_id) async {
    QuerySnapshot snapshot = await Loan_funds.where("Loan_id", isEqualTo: loan_id).get();

    if(snapshot.docs.isNotEmpty){
      String doc_id = snapshot.docs.first.id; 
      double balance = snapshot.docs.first["Outstanding_balance"];

      if(balance <= 0){
        DateTime payed = DateTime.now(); 
        return Loan_funds.doc(doc_id).update({
          "Date_payed" : payed
      }); 
      }
    }

    else{}
  }

  
  int convertToDays(String interval) {
    switch (interval) {
      case '8 weeks':
        return 8 * 7;
      case '12 weeks':
        return 12 * 7;
      case '16 weeks':
        return 20 * 7;
      case '20 weeks':
        return 20 * 7;
      case '6 months':
        return 6 * 30;
      case '12 months':
        return 12 * 30;
      case '18 months':
        return 18 * 30;
      case '24 months':
        return 24 * 30;
      case '3 years':
        return 3 * 365;
      case '6 years':
        return 6 * 365;
      case '9 years':
        return 9 * 365;
      case '12 years':
        return 12 * 365;
      default:
        return 0; // Return 0 for invalid input
    }
  }
 
}



class receipt {
  final CollectionReference Receipts = FirebaseFirestore.instance.collection("Receipts");

  Future add_recepit(int user_id, String transaction, double amount) async {
    
    DateTime date = DateTime.now();     
    QuerySnapshot snapshot = await Receipts.orderBy('Transaction_id', descending: true).limit(1).get();

    int id = -1; 

    if(snapshot.docs.isNotEmpty){
      id = snapshot.docs.first["Transaction_id"];
      id += 1; 
    }
    else {
      id += 1; 
    }
     

    return Receipts.add({
      "Transaction_id" : id, 
      "User_id" : user_id,
      "Transaction" : transaction, 
      "Date" : date, 
      "Amount" : amount
    }); 
  }

  Future get_receipt_id(int user_id) async {
    QuerySnapshot snapshot = await Receipts.where("User_id", isEqualTo: user_id).orderBy('Transaction_id', descending: true).limit(1).get();

    if(snapshot.docs.isNotEmpty){
      return snapshot.docs.first["Transaction_id"];
    }
    else {
      return "Document Not Found"; 
    }

  }

  Future <Map> get_receipt(int transaction_id) async {
    QuerySnapshot snapshot = await Receipts.where("Transaction_id", isEqualTo: transaction_id).get(); 

    if(snapshot.docs.isEmpty){
      return {}; 
    }
    else {
      return snapshot.docs.first.data() as Map; 
    }
    
  }

  Future <List> get_history(int user_id) async {
    QuerySnapshot snapshot = await Receipts.where("User_id", isEqualTo: user_id).orderBy("Date", descending: true).get(); 

    if(snapshot.docs.isEmpty){
      return [];
    }
    else {
      return snapshot.docs as List; 
    }

  }


}