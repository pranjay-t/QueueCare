import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class PastAppointment extends StatefulWidget {
  const PastAppointment({super.key});

  @override
  State<PastAppointment> createState() => _PastAppointmentState();
}

class _PastAppointmentState extends State<PastAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title:const Text("Past Appointments",style: TextStyle(color: Colors.white),),
        iconTheme:const IconThemeData(
          color: Colors.white,
        ),
      ),
      body:const Center(child: const Text("COMING SOON...")),
    );
  }
}