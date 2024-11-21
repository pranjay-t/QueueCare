import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/app_detail.dart';
import 'package:sih1620/Screens/LoginScreens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppDetail().appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      // home : const Home(currState: 1,),
      // home:const SelectDepartMent(),
      home: const Login(),
    );
  }
}

