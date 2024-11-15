import 'package:flutter/material.dart';
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
      body: Expanded(   // Element takes up entire screen from this point down
                        // the hierarchy
        child: ListView(    // Element scrolls in the event of overflow,
                            // children placed one below another
          scrollDirection: Axis.vertical,
          children: [
            Text(
              "Header Text",
              // Example of invoking Theme.of to apply a text style
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Center( // Child elements will be centered
              child: Text(
                'Centered body text but bold',
                // If you need to make a minor modification to a style, use
                // copyWith(). Make sure you assert that the style will not be
                // null by using ! after the TextStyle's name
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}