import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class Ehrscreen extends StatefulWidget {
  const Ehrscreen({super.key});

  @override
  State<Ehrscreen> createState() => _EhrscreenState();
}

class _EhrscreenState extends State<Ehrscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title:const Text("EHR Report",style: TextStyle(color: Colors.white),),
        iconTheme:const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:Center(child: const Text("COMING SOON...")),
    );
  }
}