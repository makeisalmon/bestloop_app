import 'package:bestloop_app/pages/search_page.dart';
import 'package:bestloop_app/shared.dart';
import 'package:bestloop_app/sound_services/loop_sound_service.dart';
import 'package:flutter/material.dart';
import 'package:bestloop_app/loop_card_list.dart';
import 'package:bestloop_app/loop_files/loop_data.dart';
import 'package:bestloop_app/loop_files/loop_data_dictionary.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoopSoundService.pauseLoop();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text( "Leaderboard", 
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        shadows: [const Shadow(
                          color: BestLoopColors.primaryA,
                          blurRadius: 8,
                          offset: Offset.zero,
                        )],
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white,),
                      onPressed: () => showDialog<String>(
                        barrierDismissible: true,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) => SearchPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 566,
              child: LoopList(
                name: 'Top Loops',
                gradientColors: const [Color(0xFFB500B5), Color(0xFF4F004F)],
                loopDataList: loopDataDictionary.values.toList(),
              ),
            ),
            const SizedBox(height: 8.0), 
            SizedBox(
              height: 566,
              child: LoopList(
                name: 'Featured Worldwide',
                gradientColors: const [Color(0xFF6100B5), Color(0xFF4F004F)],
                loopDataList: loopDataDictionary.values.toList(),
              ),
            ),
            const SizedBox(height: 8.0), 
          ],
        ),
      ),
    );
  }
}