import 'package:flutter/material.dart';
import 'package:sih1620/Screens/bookAppointmentScreens/queue_screen.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class PaymentGateScreen extends StatefulWidget {
  const PaymentGateScreen({super.key});

  @override
  State<PaymentGateScreen> createState() => _PaymentGateScreenState();
}

class _PaymentGateScreenState extends State<PaymentGateScreen> {
  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Transaction completed'),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: const Text(
          "Pay Now",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Payment Accepted ?'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Colors.blue),
                    )),
                  ),
                  onPressed: () {
                    showSnackBar(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QueueScreen(
                            token: "BAFK_54",
                            peopleBeforeYou: 10,
                            time: Duration(hours: 0, minutes: 30, seconds: 00),
                          ),
                        ));
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Colors.blue),
                    )),
                  ),
                  onPressed: () {},
                  child: const Text("No"),
                )
              ],
            )
          ],
        ),
      
    );
  }
}
