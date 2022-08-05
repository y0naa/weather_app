// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';

import 'utilities/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimaryColor,
      body: Column(
        children: const [
          CurrentWeather(),
          TodayWeather(),
        ],
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 230,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: cGradientColors[0]),
        gradient: const LinearGradient(
            colors: cGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                CupertinoIcons.square_grid_2x2,
                color: Colors.white,
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.white,
                  ),
                  Text(
                    " ${currentTemp.location!}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Text(
                    "7 days",
                    style: TextStyle(
                      fontSize: 18,
                      color: cTextColorSecondary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: cTextColorSecondary,
                    size: 15,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherWidget(todayWeather[0]),
                WeatherWidget(todayWeather[1]),
                WeatherWidget(todayWeather[2]),
                WeatherWidget(todayWeather[3])
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  // ignore: use_key_in_widget_constructors
  const WeatherWidget(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Text(
            "${weather.current}\u00B0",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather.image!),
            width: 50,
            height: 50,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            weather.time!,
            style: const TextStyle(fontSize: 16, color: cTextColorSecondary),
          )
        ],
      ),
    );
  }
}
