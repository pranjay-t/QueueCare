import 'package:flutter/material.dart';
import 'package:sih1620/Screens/drawerScreens/bed_screen.dart';
import 'package:sih1620/Screens/drawerScreens/ehr_screen.dart';
import 'package:sih1620/Screens/drawerScreens/past_appointment.dart';
import 'package:sih1620/Screens/bookAppointmentScreens/select_department.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class MyAppDrawer extends StatefulWidget {
  final int currState;
  const MyAppDrawer({super.key, required this.currState});

  @override
  State<MyAppDrawer> createState() => _MyAppDrawerState();
}

class _MyAppDrawerState extends State<MyAppDrawer> {
  late int state;

  @override
  void initState() {
    super.initState();
    state = widget.currState;
  }

  void onTileTap(int newState) {
    setState(() {
      state = newState;
    });

    if (newState == 1) {
      Navigator.pop(context); 
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectDepartMent()));
    } else if (newState == 2) {
      Navigator.pop(context); 
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PastAppointment()));
    } else if (newState == 3) {
      Navigator.pop(context); 
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Ehrscreen()));
    } else if (newState == 4) {
      Navigator.pop(context); 
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const BedScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    const tile =  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      );
    return Drawer(
      
      elevation: 5,
      shape: tile,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Pallete().appTheme,
            ),
            child: const Center(
              child: Text(
                'Care Crust',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            shape: tile,
            leading:  Icon(
              Icons.home,
              color: (state == 1) ? Colors.white: Colors.black,
            ),
            tileColor: (state == 1) ? Pallete().appTheme : Colors.white,
            title: Text(
              'Home',
              style: TextStyle(
                color: (state == 1) ? Colors.white : Colors.black,
              ),
            ),
            onTap: () => onTileTap(1),
          ),
          ListTile(
            shape: tile,
            leading:  Icon(
              Icons.history,
              color: (state == 2) ? Colors.white: Colors.black,
            ),
            tileColor: (state == 2) ? Pallete().appTheme : Colors.white,
            title: Text(
              'Past Appointments',
              style: TextStyle(
                color: (state == 2) ? Colors.white : Colors.black,
              ),
            ),
            onTap: () => onTileTap(2),
          ),
          ListTile(
            shape: tile,
            leading:  Icon(
              Icons.article,
              color: (state == 3) ? Colors.white: Colors.black,
            ),
            tileColor: (state == 3) ? Pallete().appTheme : Colors.white,
            title: Text(
              'EHR',
              style: TextStyle(
                color: (state == 3) ? Colors.white : Colors.black,
              ),
            ),
            onTap: () => onTileTap(3),
          ),
          ListTile(
            shape: tile,
            leading:  Icon(
              Icons.bed,
              color: (state == 4) ? Colors.white: Colors.black,
            ),
            tileColor: (state == 4) ? Pallete().appTheme : Colors.white,
            title: Text(
              'Bed Availability',
              style: TextStyle(
                color: (state == 4) ? Colors.white : Colors.black,
              ),
            ),
            onTap: () => onTileTap(4),
          ),
        ],
      ),
    );
  }
}
