import 'package:flutter/material.dart';
import 'package:sih1620/Screens/drawerScreens/upcoming_screen.dart';
import 'package:sih1620/AppDetail/app_detail.dart';
import 'package:sih1620/Screens/drawerScreens/drawer.dart';
import 'package:sih1620/utils/home_card.dart';
import 'package:sih1620/AppDetail/pallete.dart';
import 'package:sih1620/Screens/bookAppointmentScreens/select_department.dart';

class Home extends StatefulWidget {
  final int currState;
  const Home({super.key, required this.currState});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete().appTheme,
        title: Text(
          AppDetail().appName,
          style: const TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.qr_code),
          ),
        ],
      ),
      drawer: MyAppDrawer(
        currState: widget.currState,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Pallete().appTheme,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                width: double.infinity,
                height: 170,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello ! \nWant Appointment?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeCard(
                          icon: Icons.calendar_month_outlined,
                          title: 'Upcoming..',
                          theme: Color.fromARGB(255, 125, 240, 184),
                          page: UpcomingScreen(),
                        ),
                        HomeCard(
                          icon: Icons.add_circle_outline,
                          title: 'Book Now',
                          theme: Color.fromARGB(255, 143, 178, 239),
                          page: SelectDepartMent(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Pallete().appTheme,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      width: double.infinity,
                      height: 70,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming List",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildUpcomingListItem("AFtk_5", "5C", "09-09-2024", "03:00"),
                    buildUpcomingListItem("BzKl", "09", "09-09-2024", "03:00"),
                    buildUpcomingListItem("CrZJ", "3A", "09-09-2024", "03:00"),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget buildUpcomingListItem(
    String token, String counter, String date, String time) {
  return Container(
    margin:const EdgeInsets.symmetric(vertical: 5),
    padding:const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.purple, width: 2),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.list_alt, color: Colors.black54, size: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  token,
                  style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Counter No - $counter",
                  style:const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              date,
              style:const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.black54, size: 18),
                const SizedBox(width: 5),
                Text(
                  time,
                  style:const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
