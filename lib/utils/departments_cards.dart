import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sih1620/Screens/bookAppointmentScreens/time_slot_screen.dart';
import 'package:sih1620/Config/secret.dart';

class DepartmentsCards extends StatefulWidget {
  const DepartmentsCards({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DepartmentsCardsState createState() => _DepartmentsCardsState();
}

class _DepartmentsCardsState extends State<DepartmentsCards> {
  List<dynamic> departments = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    final response = await http.get(Uri.parse(Secret().departmentAPI));

    if (response.statusCode == 200) {
      setState(() {
        departments = json.decode(response.body);
      });
    } else {
      throw Exception('Something gone wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: departments.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                final departmentName = department['departmentName'];
                final departmentImageUrl = (department['departmentImageUrl'].toString()).replaceFirst('https', 'http');
                final status = department['isAvailable'];

                return GestureDetector(
                  onTap: () {
                    status == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TimeSlotScreen(
                                idx: index,
                              ),
                            ),
                          )
                        : null;
                  },
                  child: Card(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: const EdgeInsets.all(8),
                    color: status == true
                        ? const Color.fromARGB(255, 98, 212, 121)
                        : Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (status == true && departmentImageUrl != null)
                          Image.network(
                            departmentImageUrl,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print(error.toString());
                              print(departmentImageUrl);
                              return const Icon(Icons
                                  .error); 
                            },
                          )
                        else
                          const Icon(
                            Icons.block,
                            size: 50,
                            color: Colors.white,
                          ),
                        const SizedBox(height: 10),
                        Text(
                          departmentName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
