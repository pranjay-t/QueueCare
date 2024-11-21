import 'package:flutter/material.dart';
import 'package:sih1620/AppDetail/pallete.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color theme;
  final Widget page;
  const HomeCard({super.key,required this.icon,required this.title,required this.theme,required this.page});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Card(
          color: theme,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Pallete().appTheme,
                ),
                const SizedBox(height: 10),
                 Text(
                  title,
                  textAlign: TextAlign.center, 
                  style:const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}