import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sih1620/Screens/paymentGateWay/payment_gate_screen.dart';
import 'package:sih1620/AppDetail/pallete.dart';
import 'package:sih1620/Config/secret.dart';

class TimeSlotScreen extends StatefulWidget {
  final int idx;
  const TimeSlotScreen({super.key, required this.idx});

  @override
  State<TimeSlotScreen> createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  List<dynamic> timeSlot = [];
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    fetchTimeSlots();
  }

  Future<void> fetchTimeSlots() async {
    final response = await http.get(Uri.parse(Secret().departmentAPI));
    if (response.statusCode == 200) {
      setState(() {
        timeSlot = json.decode(response.body)[widget.idx]['timeSlots'];
      });
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: const Text(
          "Time Slot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: timeSlot.isEmpty
            ?  Center(child: CircularProgressIndicator(
              color: Pallete().appTheme,
            ))
            : Column(
                children: [
                  const Text(
                    "Select Time",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  Expanded(
                    child: ListView.builder(
                      itemCount: timeSlot.length,
                      itemBuilder: (context, index) {
                        final String fromTime = timeSlot[index]['startTime'];
                        final String toTime = timeSlot[index]['endTime'];
                        final String time = "$fromTime - $toTime";
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  side: BorderSide(
                                    color: selectedTime == time
                                        ? Colors.blue
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.03,
                                    horizontal: size.width * 0.05,
                                  ),
                                  child: Center(
                                    child: Text(
                                      time,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  ElevatedButton(
                    onPressed: selectedTime != null
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentGateScreen(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape:const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      backgroundColor: Pallete().appTheme,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      selectedTime != null ? "Book Now" : "Select Time",
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            selectedTime != null ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
