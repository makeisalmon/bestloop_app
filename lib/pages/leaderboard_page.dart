import 'package:flutter/material.dart';
import 'package:bestloop_app/loop_card_list.dart';
import 'package:bestloop_app/loop_files/loop_data.dart';
import 'package:bestloop_app/loop_files/loop_data_dictionary.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text("Leaderboard", style: Theme.of(context).textTheme.displayMedium),
                ],
              ),
            ),
            Expanded(
              child: LoopList(
                name: 'Top Loops',
                gradientColors: [Colors.red, Colors.orange],
                loopDataList: loopDataDictionary.values.toList(),
              ),
            ),
            const SizedBox(height: 8.0), 
            Expanded(
              child: LoopList(
                name: 'Popular Loops',
                gradientColors: [Colors.blue, Colors.purple],
                loopDataList: loopDataDictionary.values.toList(),
              ),
            ),
            const SizedBox(height: 8.0), 
            Expanded(
              child: LoopList(
                name: 'New Loops',
                gradientColors: [Colors.green, Colors.red],
                loopDataList: loopDataDictionary.values.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}