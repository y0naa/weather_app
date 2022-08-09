
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utilities/constants.dart';
import 'utilities/models.dart';

class ExtraWeather extends StatelessWidget {
  final Weather temp;
  // ignore: use_key_in_widget_constructors
  const ExtraWeather(this.temp);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        // wind
        Column(
          children: [
            const Icon(
              CupertinoIcons.wind,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${temp.wind}kmph",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Text(
              "Wind",
              style: TextStyle(
                color: cSubheadingColor,
                fontSize: 16,
              ),
            ),
          ],
        ),

        // humidity
        Column(
          children: [
            const Icon(
              CupertinoIcons.drop_fill,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${temp.humidity}%",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Text(
              "Humidity",
              style: TextStyle(
                color: cSubheadingColor,
                fontSize: 16,
              ),
            ),
          ],
        ),

        // rain
        Column(
          children: [
            const Icon(
              CupertinoIcons.cloud_drizzle,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${temp.chanceRain}%",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Text(
              "Chance of rain",
              style: TextStyle(
                color: cSubheadingColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
