import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

///  Stores the commonly used brand colors for the app and some preset gradients to reduce code
///  redundancy. Some widgets will still need to construct their own LinearGradient for special
///  cases.
class ThemeColors {
  static const primaryA = Color(0xFFFF008C);
  static const primaryB = Color(0xFFB500B5);
  static const secondaryA = Color(0xFFB500B5);
  static const secondaryB = Color(0xFF6100B5);

  static const primaryGradient = LinearGradient(
    begin: Alignment(0, -1),
    end: Alignment(0, 1),
    colors: [primaryA, primaryB],
  );
  static const secondaryGradient = LinearGradient(
    begin: Alignment(0, -1),
    end: Alignment(0, 1),
    colors: [secondaryA, secondaryB],
  );
}


/// Standard brand button for the app. Takes an optional icon parameter to display to the left of
/// the text.
class BestLoopButton extends StatelessWidget {
  final String text;
  final LinearGradient gradient;
  final Icon? icon;
  final VoidCallback onPressed;
  const BestLoopButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradient = ThemeColors.primaryGradient,
  });

  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 44,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: const BorderRadius.all(Radius.circular(22))
            
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 22),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /* display optional icon property if present. May override icon color in the future
                to always be white. */
                Container(
                  child: icon == null
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.fromLTRB(0,0,8,0),
                          child: icon,
                        ),
                ),
                Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  height: -.1, // A slight text offset gives better weight to the button
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BestLoopTickbox extends StatelessWidget {
  const BestLoopTickbox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:(){print("Tapped");},
        child: Padding(
          padding: EdgeInsets.all(12), // Padding here ensures tappable space is 44 sq. px.
          child: Container(
            decoration: BoxDecoration(
              border: const GradientBoxBorder(gradient: ThemeColors.primaryGradient, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SizedBox.square(dimension: 20,),
          ),
        ),
      ),
    );
  }
}