// ignore_for_file: file_names

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/ExtraWeather.dart';
import 'package:weather_app/utilities/constants.dart';

import 'DetailsPage.dart';
import 'utilities/models.dart';

Weather currentTemp = Weather(current: 0);
Weather tomorrowTemp = Weather(current: 0);
List<Weather> todayWeather = [];
List<Weather> sevenDays = [];
String lat = "-6.2146";
String lon = "106.8451";
String city = "Jakarta";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((val) {
      currentTemp = val[0];
      todayWeather = val[1];
      tomorrowTemp = val[2];
      sevenDays = val[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
      height: size.height * 0.73,
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
        boxShadow: const [
          BoxShadow(
            color: Color(0xff053F8D),
            offset: Offset(0, 25),
            spreadRadius: -13,
          ),
        ],
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
                    " ${currentTemp.location}",
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
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DotsIndicator(
                  dotsCount: 1,
                  decorator: const DotsDecorator(
                    color: Colors.yellow,
                    activeColor: Colors.yellow,
                  ),
                ),
                const Text(
                  "Updated 10 mins ago",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.4,
            height: size.width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "http://openweathermap.org/img/wn/${currentTemp.image}@2x.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 100,
                ),
                child: Text(
                  currentTemp.current.toString(),
                  style: const TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  "\u00B0",
                  style: TextStyle(
                    fontSize: 150,
                    fontWeight: FontWeight.bold,
                    color: cSubheadingColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            currentTemp.name!,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: cTextColorPrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 3,
            ),
            child: Text(
              currentTemp.day!,
              style: const TextStyle(
                fontSize: 18,
                color: cSubheadingColor,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ExtraWeather(currentTemp),
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
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DetailsPage(tomorrowTemp, sevenDays);
                  },
                ),
              );
            },
            child: Row(
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
                WeatherWidget(todayWeather[3]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {

  thisTime() {
    
  }

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
          Image.network(
              "http://openweathermap.org/img/wn/${weather.image!}@2x.png",
              height: 50),
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
