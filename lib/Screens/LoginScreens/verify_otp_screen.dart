import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sih1620/Screens/drawerScreens/home.dart';
import 'package:http/http.dart' as http;
import 'package:sih1620/AppDetail/pallete.dart';
import 'package:sih1620/Config/secret.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String? phone;
  const VerifyOtpScreen({super.key,required this.phone});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  
  void showSnackBarCorrect(BuildContext context,String message) {
      SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration:const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showSnackBarWrong(BuildContext context,String message) {
      SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration:const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isOtpValid = true;
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String getOtpFromControllers() {
    String otp = '';
    for (var controller in _otpControllers) {
      otp += controller.text;
    }
    return otp;
  }

  Future<void> submitOtpForm() async { 

    final Map<String, String?> formData = {
      'phoneNumber' : widget.phone,
      'otp' : getOtpFromControllers(),
    };

    try {
      final response = await http.post(
        Uri.parse(Secret().verifyOtpAPI),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );
      String message = json.decode(response.body)['message'];
      if (response.statusCode == 200) {
        
        if(mounted){
          showSnackBarCorrect(context, message);
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Home(currState: 1,)));
        }

      } else {

        String message = json.decode(response.body)['message'];
        if(mounted){
          showSnackBarWrong(context, message);
        }
        print('Server error: ${response.statusCode}');

      }
    } catch (e) {

      if(mounted){
          showSnackBarWrong(context, e.toString());
        }
      print('Exception: $e');

    }
  }

  void verifyOtp() {
    bool allFilled = _otpControllers.every((controller) => controller.text.isNotEmpty);

    if (allFilled) {
      setState(() {
        isOtpValid = true;
      });
      submitOtpForm();
    } else {
      setState(() {
        isOtpValid = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Phone Number',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Pallete().appTheme,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Verify your Phone number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your OTP code here',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => _buildOtpBox(index)),
            ),
            if (!isOtpValid)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '*Please fill all the OTP fields',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Didn\'t receive any code?',
                  style: TextStyle(fontSize: 12),
                ),
                TextButton(
                  onPressed: () {
                    // Handle resend code action here
                  },
                  child: const Text(
                    'Resend New Code',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 14),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                verifyOtp();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  )),
              child: const Text(
                'Verify',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // If user enters text, move focus to the next field
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              _focusNodes[index]
                  .unfocus(); // Dismiss the keyboard at last digit
            }
          } else if (index > 0) {
            // If user clears text, move focus to the previous field
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }
}
