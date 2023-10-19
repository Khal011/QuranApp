// ignore_for_file: camel_case_types, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:qapp3/constants.dart';

class locationgetter extends StatefulWidget {
  const locationgetter({super.key});

  @override
  State<locationgetter> createState() => _locationgetterState();
}

class _locationgetterState extends State<locationgetter> {
  var text = "press";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(text),
          onPressed: () {
            getloc();
          },
        ),
      ),
    );
  }
}

Future<Position> getloc() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition();
  return position;
}

Future getAddress(Position position) async {
  try {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placeMark = newPlace[0];
    globalLoc = "${placeMark.administrativeArea}, ${placeMark.locality}.";
  } on Exception catch (_) {
    globalLoc = "Unknown, need wifi.";
  }
}
