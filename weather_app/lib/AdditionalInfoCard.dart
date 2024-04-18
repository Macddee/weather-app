import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  final IconData icon;
  final String str;
  final String numbers;
  const AdditionalInfoCard(
      {
        super.key,
        required this.icon,
        required this.str,
        required this.numbers,
      }
      );

  @override
  Widget build(BuildContext context) {

    return  Card(
      elevation: 0,
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            // the first child, icon
            Icon(icon, size: 30,),

            //second child, text
            Padding(
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              child: Text(str,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            //the number child, last
            Text(numbers,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}