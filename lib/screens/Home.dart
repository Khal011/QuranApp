// ignore_for_file: unused_import, file_names, non_constant_identifier_names, unused_local_variable, unnecessary_string_interpolations

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:qapp3/constants.dart';
import 'package:qapp3/functions/location.dart';
import 'package:qapp3/main.dart';
import 'package:intl/intl.dart';

// fajr sunrise dhuhr asr maghrib isha none
Padding HomeScreen = Padding(
  padding: const EdgeInsets.all(0),
  child: FutureBuilder(
    future: getlocvar,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          decoration: BoxDecoration(color: lightbrown),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ImageIcon(
                  const AssetImage("images/home.png"),
                  size: 50,
                  color: mediumbrown,
                ),
                const SizedBox(
                  height: 25,
                ),
                CircularProgressIndicator(
                  color: const Color(0xFF645D4D),
                  backgroundColor: lightbrown,
                )
              ])),
        );
      } else {
        if (snapshot.hasError) {
          getlocvar = getloc();
          return const Text('Error');
        } else {
          final params = CalculationMethod.karachi.getParameters();
          params.madhab = Madhab.shafi;
          // params.adjustments.fajr = 2;
          final date = DateComponents.from(DateTime.now());

          final prayerTimes = PrayerTimes(
              Coordinates(snapshot.data!.latitude, snapshot.data!.longitude),
              date,
              params);
          List values = [
            "fajr",
            "sunrise",
            "dhuhr",
            "asr",
            "maghrib",
            "isha",
            "none"
          ];
          List salat = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"];
          List salatar = [
            "الفجر",
            "الشروق",
            "الظُهر",
            "العصر",
            "المغرب",
            "العِشاء"
          ];
          var nextprayer = prayerTimes.nextPrayer().name;
          if (nextprayer == "none") nextprayer = "fajr";
          int index = values.indexOf(nextprayer);
          //values.indexOf('fajr');
          List images = [
            "images/0fajr.png",
            "images/1sunrise.png",
            "images/2dohr.png",
            "images/3asr.png",
            "images/4maghrib.png",
            "images/5isha.png"
          ];

          List times = [
            prayerTimes.fajr,
            prayerTimes.sunrise,
            prayerTimes.dhuhr,
            prayerTimes.asr,
            prayerTimes.maghrib,
            prayerTimes.isha
          ];
          return Container(
              color: lightbrown,
              child: ListView(
                children: [
                  Image.asset(
                    images[index],
                    scale: 1,
                  ),
                  SizedBox(
                    height: size.longestSide.toDouble() * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: darkestbrown),
                    margin: const EdgeInsets.all(5),
                    child: StreamBuilder(
                      stream: diffstream(times[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return ListTile(
                          tileColor: darkestbrown,
                          textColor: lightbrown,
                          titleAlignment: ListTileTitleAlignment.center,
                          contentPadding: const EdgeInsets.all(10),
                          leading: Icon(
                            Icons.access_time_rounded,
                            color: lightbrown,
                            size: 45,
                          ),
                          title: Text(
                            " ${salat[index]} - ${DateFormat.jm().format(times[index])} - ${salatar[index]}",
                            style: const TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            "${diff(times[index])}",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
        }
      }
    },
  ),
);

class SalatRow extends StatelessWidget {
  final String salatName;
  final String SalatTime;
  const SalatRow({required this.salatName, required this.SalatTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Divider(
            color: darkestbrown,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salatName,
                  style: TextStyle(
                      color: darkestbrown,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Text(SalatTime,
                    style: TextStyle(
                        color: darkestbrown,
                        fontSize: 18,
                        fontWeight: FontWeight.w400))
              ],
            ),
          )
        ],
      ),
    );
  }
}

String diff(DateTime salat) {
  DateTime now = DateTime.now();

  Duration difference = salat.difference(now);
  String first = "";
  if (!difference.isNegative) first = "-";
  int days = difference.inDays;
  int hours = difference.inHours % 24;
  var minutes = difference.inMinutes % 60;
  String zm = "";
  String zs = "";
  var seconds = difference.inSeconds % 60;
  if (minutes < 10) zm = "0";
  if (seconds < 10) zs = "0";
  return "  \n$first $hours:$zm$minutes:$zs$seconds";
}

Stream<String> diffstream(DateTime salat) {
  return Stream.periodic(const Duration(seconds: 1), (int count) {
    DateTime now = DateTime.now();

    Duration difference = salat.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return "Remaining $hours:$minutes:$seconds";
  });
}
