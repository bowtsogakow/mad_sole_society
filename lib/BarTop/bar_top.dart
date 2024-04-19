import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart';

class TitleText extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return const Text(
      "Sole Society", 
      style: TextStyle(
        fontSize: 30,
        fontFamily: "Times New Roman", 
      ),

    );
  }

}


class TopBar extends StatelessWidget implements PreferredSizeWidget{

  var db = Database(); 

  @override
  Widget build(BuildContext context){
    return AppBar(
      title : TitleText(),
      actions : [
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {
            // Add your search functionality here
            print(db.searchName("Fresh Foam Arishi v4 Bungee Lace with Top Str")); 
            print(" Women "); 
            print(db.searchWomen());
            print(" Men ");
            print(db.searchMen());
            print(" Kids");
            print(db.searchKids());
            print(" Running");
            print(db.searchRunning());
            print(" Basketball");
            print(db.searchBasketball());
            print(" Aesthetic");
            print(db.searchAesthethic());
            print(" Skateboarding");
            print(db.searchSkateboarding());
            print("Nike"); 
            print(db.searchBrand("Nike"));
            print("Adidas");
            print(db.searchBrand("Adidas"));
            print(" Vans");
            print(db.searchBrand("Vans"));
            print("Converse"); 
            print(db.searchBrand("Converse"));
            print("New Balance");
            print(db.searchBrand("New Balance"));
            print("Dior");
            print(db.searchBrand("Dior"));

          },
        ),
      ]
    ); 
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}