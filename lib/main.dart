// ignore_for_file: unused_import, unused_local_variable
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'screens/Qibla.dart';
import 'screens/Quran.dart';
import 'screens/Salat.dart';
import 'package:qapp3/constants.dart';
import 'functions/location.dart';
import 'package:qapp3/constants/tafseer.dart';
import 'package:qapp3/constants/quran.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Navigationnn(),
      // home: testingcenter,
      title: 'DashboardScreen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: lightbrown,
          secondary: darkestbrown,
        ),
      ),
    );
  }
}

class Navigationnn extends StatefulWidget {
  const Navigationnn({super.key});

  @override
  State<Navigationnn> createState() => NavigationnnState();
}

class NavigationnnState extends State<Navigationnn> {
  List<Widget> pageList = screens;

  @override
  void initState() {
    super.initState();
    size = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: screens[globalIndex],

        //Bottom Navigation Bar added
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: globalIndex,
            onTap: (index) {
              setState(() {
                globalIndex = index;
              });
            },
            selectedItemColor: yellow,
            unselectedItemColor: mediumbrown,
            backgroundColor: darkestbrown,
            iconSize: 38.0,
            selectedFontSize: 15,
            unselectedFontSize: 12,
            elevation: 0.0,
            items: [
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("images/home.png"),
                    // color: Color(0xFF3A5A98),
                  ),
                  backgroundColor: lightbrown,
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("images/soujoud.png"),
                    // color: Color(0xFF3A5A98),
                  ),
                  backgroundColor: lightbrown,
                  label: "Salat"),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("images/coran.png"),
                    // color: Color(0xFF3A5A98),
                  ),
                  backgroundColor: lightbrown,
                  label: "Quran"),
              BottomNavigationBarItem(
                icon: const ImageIcon(
                  AssetImage("images/qibla.png"),
                  // color: Color(0xFF3A5A98),
                ),
                backgroundColor: lightbrown,
                label: "Qibla",
              )
            ]));
  }
}

Center testingcenter = Center(
  child: Text(
    tafseer["1"].toString(),
    style: const TextStyle(fontSize: 10),
  ),
);
