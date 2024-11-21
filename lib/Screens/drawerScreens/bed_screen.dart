import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class BedScreen extends StatefulWidget {
  const BedScreen({super.key});

  @override
  State<BedScreen> createState() => _BedScreenState();
}

class _BedScreenState extends State<BedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title:const Text("Bed Availability",style: TextStyle(color: Colors.white),),
        iconTheme:const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:Center(child: const Text("COMING SOON...")),
    );
  }
}