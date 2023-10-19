// ignore_for_file: unused_import, file_names, non_constant_identifier_names, unused_local_variable, avoid_print, unnecessary_import
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:qapp3/constants.dart';
import 'package:qapp3/functions/location.dart';
import 'package:qapp3/main.dart';
import 'package:intl/intl.dart';

Padding SalatScreen = Padding(
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
                  const AssetImage("images/soujoud.png"),
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
          return Container(
              color: lightbrown,
              child: ListView(
                children: [
                  SizedBox(
                    height: size.longestSide.toDouble() * 0.03,
                  ),
                  FutureBuilder(
                    future: getAddress(snapshot.data!),
                    builder: (context2, snapshot2) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: const Color(0xFF645D4D),
                            backgroundColor: lightbrown,
                          ),
                        );
                      } else {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: darkestbrown),
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              tileColor: darkestbrown,
                              textColor: lightbrown,
                              titleAlignment: ListTileTitleAlignment.center,
                              contentPadding: const EdgeInsets.all(16),
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: lightbrown,
                                size: 45,
                              ),
                              title: Text(
                                globalLoc,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ));
                      }
                    },
                  ),
                  SizedBox(
                    height: size.longestSide.toDouble() * 0.02,
                  ),
                  SalatRow(
                      salatName: "    Fajr : الفجر",
                      SalatTime: DateFormat.jm().format(prayerTimes.fajr)),
                  SalatRow(
                      salatName: "    Sunrise : الشروق",
                      SalatTime: DateFormat.jm().format(prayerTimes.sunrise)),
                  SalatRow(
                      salatName: "    Dhuhr : الظُهر",
                      SalatTime: DateFormat.jm().format(prayerTimes.dhuhr)),
                  SalatRow(
                      salatName: "    Asr : العصر",
                      SalatTime: DateFormat.jm().format(prayerTimes.asr)),
                  SalatRow(
                      salatName: "    Maghrib : المغرب",
                      SalatTime: DateFormat.jm().format(prayerTimes.maghrib)),
                  SalatRow(
                      salatName: "    Isha : العِشاء",
                      SalatTime: DateFormat.jm().format(prayerTimes.isha))
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
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
                Text(SalatTime,
                    style: TextStyle(
                        color: darkestbrown,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> testing() async {
  // print(tafseer["1"]!.length);
  // print(tafseer["1"].toString());
  // print(quran["1"].toString());
  // print(tafseer["1"][0]["text"].toString());
  return;
}
