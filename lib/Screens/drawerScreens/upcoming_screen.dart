import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class UpcomingScreen extends StatefulWidget {
  
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: const Text(
          "Appointments",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Text("Your appointments"),
    );
  }
}
