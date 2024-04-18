import 'package:flutter/material.dart';
class HoulyWeatherUpdateCard extends StatelessWidget {
   final String time;
   final String temp;

  const HoulyWeatherUpdateCard(
      {super.key,
        required this.time,
        required this.temp,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            children: [
              Text(time,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),),

              //Icon Column
              const SizedBox( height: 12,),
              const Icon(Icons.cloud, size: 40,),

              //Time Column
              const SizedBox( height: 12,),
              Text(temp, style: const TextStyle(fontSize: 17),)
            ],

          ),
        ),
      ),
    );
  }
}