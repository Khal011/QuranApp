// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:qapp3/tabs/bookmark_tab.dart';
import 'package:qapp3/tabs/surah_tab.dart';
import 'package:qapp3/constants.dart';

Scaffold QuranScreen = const Scaffold(
  body: Quranclass(),
);

class Quranclass extends StatelessWidget {
  const Quranclass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbrown,
      appBar: _appBar(),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: _greeting(),
                    ),
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: lightbrown,
                      automaticallyImplyLeading: false,
                      shape: Border(
                          bottom: BorderSide(
                              width: 3, color: yellow.withOpacity(.1))),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: _tab(),
                      ),
                    )
                  ],
              body: const TabBarView(children: [SurahTab(), BookmarkTab()])),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: darkestbrown,
        labelColor: darkestbrown,
        indicatorColor: yellow,
        indicatorWeight: 3,
        tabs: [
          _tabItem(label: "Surah"),
          _tabItem(label: "Bookmark"),
        ]);
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
      ),
    );
  }

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_lastRead()],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, .55, 1],
                  colors: [yellow, lightbrown, darkestbrown])),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "images/coran.png",
              width: 30,
              height: 30,
              color: lightbrown,
            )),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "images/coran.png",
                    width: 30,
                    height: 30,
                    color: darkestbrown,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Last Read',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Al-Fatihah',
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Ayat No: 1',
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: lightbrown,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              onPressed: (() => {}),
              icon: Image.asset(
                "images/coran.png",
                width: 40,
                height: 40,
                color: yellow,
              )), //menuicon
          const SizedBox(
            width: 12,
          ),
          Text('بسم الله الرحمن الرحيم',
              style: TextStyle(
                  fontSize: 26, fontFamily: 'me_quran', color: darkestbrown)),
          const SizedBox(
            width: 12,
          ),
          IconButton(
              onPressed: (() => {}),
              icon: Image.asset(
                "images/coran.png",
                width: 40,
                height: 40,
                color: yellow,
              ))
        ]),
      );
}
