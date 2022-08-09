import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/ExtraWeather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/utilities/models.dart';

class DetailsPage extends StatelessWidget {
  final Weather tomorrowTemp;
  final List<Weather> sevenDays;

  const DetailsPage(this.tomorrowTemp, this.sevenDays, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimaryColor,
      body: Column(
        children: [
          TomorrowWeather(tomorrowTemp),
          SevenDays(sevenDays),
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final Weather tomorrowTemp;
  const TomorrowWeather(this.tomorrowTemp, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(2),
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
          Padding(
            padding:
                const EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                Row(
                  children: const [
                    Icon(CupertinoIcons.calendar, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "7 days",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert, color: Colors.white)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width / 2.3,
                  height: size.width / 2.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://openweathermap.org/img/wn/${tomorrowTemp.image}@2x.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 30, height: 0.1),
                    ),
                    SizedBox(
                      height: 105, // ganti
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tomorrowTemp.max.toString(),
                            style: const TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold),
                          ),
                          Text("/${tomorrowTemp.min}\u00B0",
                              style: const TextStyle(
                                  color: cSubheadingColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      " ${tomorrowTemp.name}",
                      style: const TextStyle(
                        fontSize: 24,
                        color: cSubheadingColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 50,
              left: 50,
            ),
            child: ExtraWeather(tomorrowTemp),
          ),
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDays;
  const SevenDays(this.sevenDays, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sevenDays.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sevenDays[index].day!,
                  style: const TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Image.network(
                      "http://openweathermap.org/img/wn/${sevenDays[index].image}@2x.png",
                      height: 50,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      sevenDays[index].name!,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "+${sevenDays[index].max}\u00B0",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "+${sevenDays[index].min}\u00B0",
                      style: const TextStyle(
                          fontSize: 20, color: cTextColorSecondary),
                    ),
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
