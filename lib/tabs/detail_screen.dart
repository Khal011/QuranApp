// ignore_for_file: unnecessary_import, non_constant_identifier_names

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:qapp3/constants.dart';
import 'package:qapp3/models/surah.dart';
import 'package:qapp3/constants/quran.dart';
import 'package:qapp3/constants/tafseer.dart';

class DetailScreen extends StatelessWidget {
  final Surah surah;
  DetailScreen({super.key, required this.surah});
  late final elsurah = quran[surah.nomor.toString()];
  late final eltafseer = tafseer[surah.nomor.toString()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbrown,
      appBar: _appBar(context: context, surah: surah),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: _details(surah: surah),
          )
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView.separated(
            itemBuilder: (context, index) => _ayatItem(
                ayat: elsurah![index], ayat_tafseer: eltafseer![index]),
            itemCount: elsurah!.length,
            separatorBuilder: (context, index) => Container(),
          ),
        ),
      ),
    );
  }

  Widget _ayatItem(
          {required Map<String, Object> ayat,
          required Map<String, Object> ayat_tafseer}) =>
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: yellow, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: darkestbrown,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                      '${ayat["verse"]}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              '${ayat["text"]}',
              style: TextStyle(
                  color: darkestbrown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "me_quran"),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('${ayat_tafseer["text"]}',
                style: TextStyle(
                    color: darkestbrown,
                    fontSize: 18,
                    fontFamily: "quran",
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.right)
          ],
        ),
      );

  Widget _details({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(children: [
          Container(
            height: surah.nomor != 9 ? 257 : 157,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0, .6, 1],
                    colors: [Colors.white, lightbrown, yellow])),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  surah.namaLatin,
                  style: TextStyle(
                      color: yellow, fontWeight: FontWeight.w500, fontSize: 26),
                ),
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: darkestbrown.withOpacity(.35),
                  thickness: 2,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: TextStyle(
                        color: yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: darkestbrown),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${surah.jumlahAyat} Ayat",
                      style: TextStyle(
                        color: yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: surah.nomor != 9 ? 32 : 1,
                ),
                Text(
                  surah.nomor != 9
                      ? "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ"
                      : "",
                  style: const TextStyle(fontFamily: "me_quran", fontSize: 28),
                )
              ],
            ),
          )
        ]),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) =>
      AppBar(
        backgroundColor: lightbrown,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: (() => Navigator.of(context).pop()),
              icon: Image.asset(
                'images/svgs/back-icon.png',
                color: darkestbrown,
              )),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: darkestbrown),
          ),
          const Spacer(),
          IconButton(
              onPressed: (() => {}),
              icon: Image.asset(
                'images/svgs/search-icon.png',
                color: darkestbrown,
              )),
        ]),
      );
}
