import 'package:bestloop_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_selector/file_selector.dart';
import 'package:bestloop_app/artist_Info.dart';
import 'package:bestloop_app/tag_widget.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:bestloop_app/loop_files/loop_data.dart';
import 'package:bestloop_app/loop_files/uploads.dart';
import 'dart:io';
import 'package:bestloop_app/pages/profile_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? audioPath;
  String? imagePath;
  List<String> tags = [];
  String? licensing;
  String loopTitle = '';

  void _pickAudio() async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'audio',
      extensions: ['wav'],
    );
    final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      setState(() {
        audioPath = file.path;
      });
    }
  }

  void _pickImage() async {
    try {
      final XTypeGroup typeGroup = XTypeGroup(
        label: 'images',
        extensions: ['jpg', 'jpeg', 'png'],
      );
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
      if (file != null) {
        setState(() {
          imagePath = file.path;
        });
      } else {
        print("No file selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

void _upload() {
  if (audioPath != null && imagePath != null && licensing != null) {
    final newEntry = LoopData(
      imagePath: imagePath!,
      loopTitle: loopTitle,
      artistName: 'Kyler', // Changed from 'Artist' to 'Kyler'
      artistImagePath: 'assets/DSCF3834.JPEG', // Example path
      audioPath: audioPath!,
      licensing: licensing!,
      comments: 0,
      likes: 0,
      hasBeenOnLeaderboard: false,
      pathToWaveForm: 'assets/waveforms/new_loop.png', // Example path
      dislikes: 0,
      tags: tags,
      location: 'New Orleans', // Changed from 'Unknown' to 'New Orleans'
      topComment: 'No comments yet!', // Added default top comment text
    );

    setState(() {
      uploads['New Loop'] = newEntry; // Use a unique key for each entry
    });

    // Navigate to the uploads tab on the artist page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
        settings: RouteSettings(arguments: 'Uploads'),
      ),
    );
  } else {
    // Show an error message
  }
      globalScaffoldKey.currentState?.updatePageIndex(3);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "1. Upload Audio",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _pickAudio,
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
                  child: audioPath != null
                      ? SvgPicture.asset(
                          'assets/waveform.svg',
                          width: 48,
                          height: 48,
                        )
                      : Text(
                          "Upload Audio",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "2. Upload Image",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
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
                  child: imagePath != null
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 48,
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "3. Loop Title",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  loopTitle = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter loop title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "4. Choose Your Tags",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 12.0, bottom: 12),
            child: SmallTag(
              tags: tags,
              minTagViewHeight: 0,
              maxTagViewHeight: 150,
              tagBackgroundColor: Colors.transparent,
              selectedTagBackgroundColor: Colors.lightBlue,
              deletableTag: true,
              onDeleteTag: (index) {
                setState(() {
                  tags.removeAt(index);
                });
              },
              tagTitle: (tag) =>
                  Text(tag, style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "5. Licensing Information",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 12.0, bottom: 12),
            child: Row(
              children: [
                CustomCheckbox(
                  value: licensing == 'assets/share.svg',
                  onChanged: (bool? value) {
                    setState(() {
                      licensing = value! ? 'assets/share.svg' : null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/share.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Text(
                      'Non Commercial - Users must not use your loop for profit or other commercial purposes.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 12.0, bottom: 12),
            child: Row(
              children: [
                CustomCheckbox(
                  value: licensing == 'assets/nonC.svg',
                  onChanged: (bool? value) {
                    setState(() {
                      licensing = value! ? 'assets/nonC.svg' : null;
                    });
                  },
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/nonC.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Text(
                      'Share Alike - Users must share derivative works using the same license agreement.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: _upload,
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
        child: value
            ? const Icon(Icons.check, color: Colors.white, size: 24.0)
            : null,
      ),
    );
  }
}