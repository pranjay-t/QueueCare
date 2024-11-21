import 'package:flutter/material.dart';
import 'package:sih1620/utils/departments_cards.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class SelectDepartMent extends StatefulWidget {
  const SelectDepartMent({super.key});

  @override
  State<SelectDepartMent> createState() => _SelectDepartMentState();
}

class _SelectDepartMentState extends State<SelectDepartMent> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: const Text(
          "Departments",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child:const  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Text(
              "Select Department",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
              Expanded(child: DepartmentsCards()),
            
          ],
        ),
      ),
    );
  }
}