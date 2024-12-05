import 'dart:math';
import 'package:bestloop_app/components/waveform.dart';
import 'package:bestloop_app/loop_card_list.dart';
import 'package:bestloop_app/shared.dart';
import 'package:bestloop_app/sound_services/loop_sound_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../loop_files/loop_data.dart'; // Import the common LoopData class
import '../loop_files/loop_data_dictionary.dart'; // Import the dictionary
import 'package:bestloop_app/components/tag_widget.dart';

class DiscoverPage extends StatefulWidget {
  static List<LoopData> loopList = loopDataDictionary.values.toList();
  DiscoverPage({
    super.key,
  });
  
  @override
  _Rotting createState() => _Rotting();
}

class _Rotting extends State<DiscoverPage> {
  late LoopData currentLoopData;
  late LoopData nextLoopData;
  final PageController _pageController = PageController();
  final List<String> loopTitles = loopDataDictionary.keys.toList();
  int index = 0;
  String? lastLoopTitle;

  @override
  void initState() {
    super.initState();
    currentLoopData = DiscoverPage.loopList.first;
    if (!LoopSoundService.isPlaying) {
      LoopSoundService.changeLoop(currentLoopData.audioPath);
      LoopSoundService.playLoop();
    }
    nextLoopData = _getNextLoopData();
  }

  LoopData _getNextLoopData() {
    // final random = Random();
    // String nextTitle;
    // do {
    //   nextTitle = loopTitles[random.nextInt(loopTitles.length)];
    // } while (nextTitle == lastLoopTitle);
    // lastLoopTitle = nextTitle;
    // return loopDataDictionary[nextTitle]!;
    index++;
    if (DiscoverPage.loopList.length > 1) {
      return DiscoverPage.loopList[(index + 1) % (DiscoverPage.loopList.length) - 1];
    } else {
      return DiscoverPage.loopList.first;
    }
  }

  void _loadNextLoop() {
    LoopSoundService.changeLoop(nextLoopData.audioPath);
    LoopSoundService.playLoop();
    setState(() {
      currentLoopData = nextLoopData;
      nextLoopData = _getNextLoopData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          _loadNextLoop();
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Column(
                children: [
                  // Background Image with Gradient Overlay
                  Flexible(
                    flex: 1,
                    child: Container(
                      //width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(currentLoopData.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * (2 / 4),
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                stops: [
                                  .3,
                                  1,
                                ],
                              ),
                            ),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * (2 / 4)+1,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * (1/2) - 64,
                                ),
                                const SineWaveRectangles(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Title and Artist Information
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 44, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (2 / 4)+64,
                        width: double.infinity, // Ensures it spans the full width
                        child: Container(color: Colors.transparent), // Invisible widget
                      ),
                      Text(
                        currentLoopData.loopTitle,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        shadows: [const Shadow(
                          color: BestLoopColors.primaryA,
                          blurRadius: 8,
                          offset: Offset.zero,
                        )],
                      )
                        ,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 12.0, bottom: 12.0, left: 0.0, right: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                maxRadius: 18,
                                backgroundImage: AssetImage(
                                    currentLoopData.artistImagePath),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  currentLoopData.artistName,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SmallTag(
                        tags: currentLoopData.tags,
                        loopData: currentLoopData,
                        onDeleteTag: (index) {
                          print('Deleted tag at index: $index');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    Text(
                      '${currentLoopData.comments}',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    Text(
                      '${currentLoopData.likes}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.download),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    SizedBox(height: 44,)
                  ],
                ),
              ),
              // Scrubber and Licensing Placeholder
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Licensing Placeholder
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: SvgPicture.asset(
                          color: Colors.grey.shade600,
                          currentLoopData.licensing,
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                    // Scrubber
                    SingleChildScrollView(
                      child: Slider(
                        value: 0.5,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}