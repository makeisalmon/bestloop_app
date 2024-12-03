import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bestloop_app/artist_Info.dart';
import 'package:bestloop_app/components/tag_widget.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 12.0, bottom: 12),
            child: Text(
              "1. Upload Audio",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle upload action
              },
              child: Container(
                width: 320,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/waveform.svg',
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 12.0, bottom: 12),
            child: Text(
              "2. Upload Image",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle upload action
              },
              child: Container(
                width: 320,
                height: 340,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/waveform.svg',
                    width: 48,
                    height: 48,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 12.0, bottom: 12),
            child: Text(
              "3. Choose Your Tags",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 12.0, top: 0, bottom: 12),
            child: SmallTag(
              tags: ['DrumBeat', 'BestLoop', 'Cool'], // Example tags
              minTagViewHeight: 0,
              maxTagViewHeight: 150,
              tagBackgroundColor: Colors.transparent,
              selectedTagBackgroundColor: Colors.lightBlue,
              deletableTag: true,
              onDeleteTag: (index) {
                // Handle tag deletion
              },
              tagTitle: (tag) =>
                  Text(tag, style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 4.0, bottom: 12),
            child: Text(
              "4. Licensing Information",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 12.0, top: 0, bottom: 12),
            child: Row(
              children: [
                CustomCheckbox(
                  value: false, // Initial value
                  onChanged: (bool? value) {
                    // Handle checkbox state change
                  },
                ),
                const SizedBox(width: 8), // Space between checkbox and SVG
                SvgPicture.asset(
                  'assets/share.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 8), // Space between SVG and text box
                const Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Text(
                      'Non Commercial - Users must not use your loop for profit or other commercial purposes.',
                      style: TextStyle(color: Colors.grey,fontSize: 16), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 12.0, top: 0, bottom: 12),
            child: Row(
              children: [
                CustomCheckbox(
                  value: false, // Initial value
                  onChanged: (bool? value) {
                    // Handle checkbox state change
                  },
                ),
                const SizedBox(width: 8), // Space between checkbox and SVG
                SvgPicture.asset(
                  'assets/nonC.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 8), // Space between SVG and text box
                const Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Text(
                      'Share Alike - Users must share derivative works using the same license agreement.',
                      style: TextStyle(color: Colors.grey,fontSize: 16), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle upload action
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child:
            value ? const Icon(Icons.check, color: Colors.white, size: 24.0) : null,
      ),
    );
  }
}
