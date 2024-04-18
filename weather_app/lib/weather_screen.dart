
import "dart:convert";
import "dart:ui";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "package:weather_app/secretes.dart";

import "AdditionalInfoCard.dart";
import "HoulyWeatherUpdateCard.dart";

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

    Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String city_name = "London";
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$city_name,uk&APPID=$OpenWeatherApiKey"
        ),
      );

      final data = jsonDecode(result.body);

      if (data["cod"] != "200") {
        throw "Unable to get weather data";
      }
      return data;
     // data["list"][0]["main"]["temp"];

    }
    catch (e) {
      throw e.toString();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        actions: [ IconButton(onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),


      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return const Text("Unable to get weather data");
          }
          final data = snapshot.data!;

          final currentTemp = data["list"][0]["main"]["temp"];
          return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child:  Column(
                          children: [
                            Text("$currentTemp K",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              ),
                            ),

                            //Another children of the card
                             const SizedBox(height: 20,),
                             const Icon(Icons.cloud),



                            //another child that is the rain text
                             const SizedBox(height: 20,),
                             const Text(
                              "Rain",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // wether forcast card
              const SizedBox(height: 20),
              const Text("Weather Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                  ),

              const SizedBox(height: 13),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HoulyWeatherUpdateCard(temp: "20", time: "12:00",),
                    HoulyWeatherUpdateCard(temp: "30", time: "13:00"),
                    HoulyWeatherUpdateCard(temp: "40", time: "14:00"),
                    HoulyWeatherUpdateCard(temp: "10", time: "15:00"),
                  ],
                ),
              ),

              //additional information
              const SizedBox(height: 20,),
              const Text("Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 13,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdditionalInfoCard(numbers: "30", icon: Icons.water_drop, str: "Humidity",),
                  AdditionalInfoCard(numbers: "40", icon: Icons.air, str: "Wind Speed",),
                  AdditionalInfoCard(numbers: "50", icon: Icons.beach_access_outlined, str: "Pressure",),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}




