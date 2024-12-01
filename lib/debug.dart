import 'package:bestloop_app/artist_Info.dart';
import 'package:flutter/material.dart';
import 'loopcard.dart'; // Correct path to loop_card.dart
import 'loop_files/loop_data.dart'; // Import the LoopData class
import 'loop_files/loop_data_dictionary.dart'; // Import the dictionary
import 'loop_card_list.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "Header Text",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Center(
            child: Text(
              'Centered body text but bold',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}