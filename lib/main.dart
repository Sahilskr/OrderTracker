import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/customer_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.dark,
      ),
      home: CustomerScreen(),
    );
  }
}

