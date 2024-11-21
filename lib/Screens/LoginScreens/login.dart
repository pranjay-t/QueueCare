import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sih1620/Screens/LoginScreens/verify_otp_screen.dart';
import 'package:sih1620/AppDetail/pallete.dart';
import 'package:http/http.dart' as http;
import 'package:sih1620/Config/secret.dart';
import 'package:sih1620/Screens/drawerScreens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  bool isErrorVisible = false;

  Future<void> submitForm() async {
    final Map<String, String> formData = {
      'name': _nameController.text,
      'password': _passwordController.text,
      'age': _ageController.text,
      'phoneNumber': '+91${_phoneController.text}',
      'gender': _selectedGender ?? '',
    };

    try {
      print("hiiiiiiiiiiiiiiiii");
      final response = await http.post(
        Uri.parse(Secret().userDataAPI),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: formData,
      );
      if (response.statusCode == 200) {
        print('Server Response: ${response.body}');
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOtpScreen(
                        phone: formData['phoneNumber'],
                      )));
        }
      } else {
        print('Server error: ${response.statusCode}');
        print('Server Response: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void sendOtp() {
    if (_phoneController.text.length != 10) {
      setState(() {
        isErrorVisible = true;
      });
    } else {
      setState(() {
        isErrorVisible = false;
      });
      submitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        width: 2,
        color: isErrorVisible == false ? Pallete().appTheme : Colors.red,
      ),
    );

    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home(currState :1),),);
        },
        child: Text('skip'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Image.asset(
                height: 400,
              'assets/images/blahuser.jpeg',
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Add your details. We\'ll send you a verification code.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: border,
                        focusedBorder: border,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: border,
                        focusedBorder: border,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      hint: const Text('Select Gender'),
                      items:
                          <String>['Male', 'Female', 'Other'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: border,
                        focusedBorder: border,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: border,
                        focusedBorder: border,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: border,
                        focusedBorder: border,
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 19, horizontal: 15),
                          child: Text('+91', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                    if (isErrorVisible)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '*Please enter a valid 10-digit phone number',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: sendOtp,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'By providing my phone number, I hereby agree and accept the Terms of Service and Privacy Policy.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
