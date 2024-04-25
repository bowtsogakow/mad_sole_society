import 'package:flutter/material.dart';
import 'package:sole_society/Database/database.dart';

class Logo extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return IconButton(
      onPressed: null, 
      icon: Image.asset(
        'lib/Icons/Logo-Mad.png', 
        width : 2400.0, 
        height : 1600.0,
        fit: BoxFit.fill,
        ),
        

      
      );

  }

}


class TopBar extends StatelessWidget implements PreferredSizeWidget{

  

  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: Logo(),
      
      leadingWidth: 110,
      actions : [
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {
            // Add your search functionality here
           

          },
        ),
      ]
    ); 
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}