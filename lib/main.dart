

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/BarTop/bar_top.dart';
import 'package:sole_society/Pages/Admin_landing.dart';
import 'package:sole_society/Pages/Landing.dart';
import 'package:sole_society/Pages/signup.dart';
import 'package:sole_society/Pages/login.dart';
import 'package:sole_society/Pages/Opening.dart';
import 'package:sole_society/Database/database.dart' as DB;
import 'dart:io' as io;

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); 

  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCAI1nx8e1heWR31gzz6yxpm14fprOIoic", 
        authDomain: "madsolesociety.firebaseapp.com",
        projectId: "madsolesociety",
        storageBucket: "madsolesociety.appspot.com",
        messagingSenderId: "168894008821",
        appId: "1:168894008821:web:a89022a894b8eea2b5a4bc"));
  } else if (io.Platform.isAndroid){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA4myT3m0UqR6ahpQBE385aHvsNRdPb-mY", 
        appId: "1:168894008821:android:9f5b7462016803f3b5a4bc", 
        messagingSenderId: "168894008821", 
        projectId: "madsolesociety"));
  }


  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF333333)),
        useMaterial3: true,
      ),
      home: Landing(user_id: 1, index: 0,),
    );
  }
}

