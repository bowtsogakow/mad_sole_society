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

}

class shoes_db {


      final CollectionReference Shoes = FirebaseFirestore.instance.collection("Shoes"); 

     
}