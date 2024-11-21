import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class QueueScreen extends StatefulWidget {
  final String token;
  final int peopleBeforeYou;
  final Duration time;
  const QueueScreen({super.key, required this.token, required this.peopleBeforeYou,required this.time});

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.time; 
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        final seconds = remainingTime.inSeconds - 1;
        if (seconds >= 0) {
          remainingTime = Duration(seconds: seconds);
        } else {
          timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: const Text(
          'Your Queue',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Patient ID: ${widget.token}",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset("assets/images/Queue.jpeg"),
            const SizedBox(height: 20),
            Text(
              "${widget.peopleBeforeYou} people ahead of you",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Text(
              "Estimated Waiting Time",
              style:  TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                backgroundColor: Pallete().appTheme, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                formatDuration(remainingTime),
                style:const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
