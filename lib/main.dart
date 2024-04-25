

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sole_society/BarTop/bar_top.dart';
import 'package:sole_society/login_signup/signup.dart';
import 'package:sole_society/login_signup/login.dart';
import 'package:sole_society/login_signup/Opening.dart';
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
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Opening(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
 
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: TopBar(),
      body: Center(

        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            const Text(
              'You have pushed the button this many times:',
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            )

          ]
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add)
      ) 
    );
  }
}
