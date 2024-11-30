import 'package:bestloop_app/loopcard.dart';
import 'package:bestloop_app/shared.dart';
import 'package:flutter/material.dart';
import 'package:bestloop_app/artist_Info.dart';
import 'package:bestloop_app/tag_widget.dart'; // Import the SmallTag widget

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  /*
   * This file contains the testing page so you can debug your widgets. Changes
   * made here will not be committed to the GitHub, so modify it as you please
   * but make sure the widget you work on is in its own file. For example, the 
   * LoopCard widget code should be written in 'loopcard.dart'
   * 
   * Author: Makei Salmon
   * Last Modified: 11/14/2024
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            " ",
            // Example of invoking Theme.of to apply a text style
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Center(
            // Child elements will be centered
            child: Text(
              'Widget Test Page',
              // If you need to make a minor modification to a style, use
              // copyWith(). Make sure you assert that the style will not be
              // null by using ! after the TextStyle's name
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ArtistInfo(),
          SmallTag(
            tags: [ 'Freaky', 'E. Piano','Lofi','Longer Tag','Accordion',''], // Example tags
            onDeleteTag: (index) {
              print('Deleted tag at index: $index');
            },
          ),
          LoopCard(loop: Loop(title: "Grated Cheese (Hyper)", subtitle: "TheRealArtist ∙ Baton Rouge", imageUrl: "https://play-lh.googleusercontent.com/YcD6umM0uHwFsmO7DyibaZSVhJw1hak1Y6-XErHeyVqNYuAlxqyraTC9HEZpxTWZCMY=w480-h960-rw")),
          LoopCard(loop: Loop(title: "The Real Drop (Extra Freaky Edition)", subtitle: "TheRealArtist ∙ Baton Rouge", imageUrl: "https://th.bing.com/th/id/OIP.IDvkCPhzhQdJkCAqZIIFXwHaEK?rs=1&pid=ImgDetMain")),
          LoopCard(loop: Loop(title: "Grated Cheese (Hyper)", subtitle: "clarinetconnoisseur ∙ New Orleans", imageUrl: "https://wordsmith.org/words/images/connoisseur_large.jpg")),
          BestLoopButton(text: "Create an Account",),
          SizedBox(height: 16,),
          BestLoopButton(text: "Login", gradient: ThemeColors.secondaryGradient,),
        ],
      ),
    );
  }
}