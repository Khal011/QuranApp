// ignore_for_file: file_names, non_constant_identifier_names, unused_import, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:qapp3/constants.dart';

int last = 0;
double prevValue = 0;
bool first = true;

Scaffold QiblaScreen = Scaffold(
  backgroundColor: lightbrown,
  body: StreamBuilder(
    stream: FlutterQiblah.qiblahStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
            decoration: BoxDecoration(color: lightbrown),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.asset(
                    "images/kaaba_colored.png",
                    scale: 8,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CircularProgressIndicator(
                    color: Color(0xFF645D4D),
                  )
                ])));
      }
      double turns = 3600;
      final qiblahDirection = snapshot.data;
      double? direction = qiblahDirection!.qiblah * -1 % 360 - last * 360;
      if (!first) {
        if (prevValue.toInt() % 360 < 100 && direction.toInt() % 360 > 260) {
          last++;
          direction -= 360;
        } else if (prevValue.toInt() % 360 > 260 &&
            direction.toInt() % 360 < 100) {
          last--;
          direction += 360;
        }
      }
      first = false;
      turns = (direction / 360);
      prevValue = direction;
      var qiblacolor =
          [357, 358, 359, 0, 1, 2, 3].contains(direction.toInt().abs() % 360)
              ? "images/kaaba_colored.png"
              : "images/kaaba_dark.png";
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            qiblacolor,
            scale: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 300,
              child: AnimatedRotation(
                turns: turns,
                duration: const Duration(milliseconds: 300),
                child: Image.asset('images/qibla_compass.png'),
              )),
          const SizedBox(
            height: 100,
          ),
          Text(
            "${qiblahDirection.qiblah.toInt() * -1 % 360}°",
            style: const TextStyle(fontSize: 25),
          )
        ]),
      );
    },
  ),
);
