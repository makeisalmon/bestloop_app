import 'package:bestloop_app/shared.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BestLoopButton(
            text: "Upload Loop",
            icon: const Icon(
              Icons.upload,
              color: Colors.white,
            ),
            onPressed: (){
              print("PREsseD!");
            },
          )
        ],
      ),
    );
  }
}