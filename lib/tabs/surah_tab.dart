import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qapp3/constants.dart';
import 'package:qapp3/models/surah.dart';
import 'package:qapp3/tabs/detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');

    return surahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        initialData: const [],
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  Divider(color: darkestbrown.withOpacity(.35)),
              itemCount: snapshot.data!.length);
        }));
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                    surah: surah,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'images/svgs/nomor-surah.png',
                    color: yellow,
                    width: 40,
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Text(
                      "${surah.nomor}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                    )),
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.namaLatin,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(surah.tempatTurun.name,
                          style: const TextStyle(fontSize: 13)),
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
                      ),
                    ],
                  )
                ],
              )),
              Text(
                surah.nama,
                style: const TextStyle(fontSize: 24, fontFamily: 'me_quran'),
              ),
            ],
          ),
        ),
      );
}
