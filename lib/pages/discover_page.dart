import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../loop_files/loop_data.dart'; // Import the common LoopData class
import '../loop_files/loop_data_dictionary.dart'; // Import the dictionary
import 'package:bestloop_app/tag_widget.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _Rotting createState() => _Rotting();
}

class _Rotting extends State<DiscoverPage> {
  late LoopData currentLoopData;
  late LoopData nextLoopData;
  final PageController _pageController = PageController();
  final List<String> loopTitles = loopDataDictionary.keys.toList();
  String? lastLoopTitle;

  @override
  void initState() {
    super.initState();
    currentLoopData = loopDataDictionary['Chill Vibes']!;
    nextLoopData = _getNextLoopData();
  }

  LoopData _getNextLoopData() {
    final random = Random();
    String nextTitle;
    do {
      nextTitle = loopTitles[random.nextInt(loopTitles.length)];
    } while (nextTitle == lastLoopTitle);
    lastLoopTitle = nextTitle;
    return loopDataDictionary[nextTitle]!;
  }

  void _loadNextLoop() {
    setState(() {
      currentLoopData = nextLoopData;
      nextLoopData = _getNextLoopData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 16 / 18,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(currentLoopData.imagePath),
                                fit: BoxFit.cover,
                              ),
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
                          ),
                          // Add the SVG overlay here
                          Align(
                            alignment: Alignment.bottomLeft, // Adjust alignment as needed
                            child: Container(
                              width: 125, // Set the desired width
                              height: 125, // Set the desired height
                              child: SvgPicture.asset(
                                'assets/pink.svg', // Path to your SVG asset
                                color: Colors.pink, // Change the color of the SVG
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight, // Adjust alignment as needed
                            child: Container(
                              width: 125, // Set the desired width
                              height: 125, // Set the desired height
                              child: SvgPicture.asset(
                                'assets/pink.svg', // Path to your SVG asset
                                color: Colors.pink, // Change the color of the SVG
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter, // Adjust alignment as needed
                            child: Container(
                              width: 125, // Set the desired width
                              height: 125, // Set the desired height
                              child: SvgPicture.asset(
                                'assets/pink.svg', // Path to your SVG asset
                                color: Colors.pink, // Change the color of the SVG
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Waveform Placeholder
              Container(
                height: 0,
                color: Colors.transparent,
                child: const Center(child: Text('Waveform Placeholder')),
              ),
              // Title and Artist Information
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6, // Adjust this value to position correctly
                left: 8.0,
                right: 8.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLoopData.loopTitle,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 16.0, bottom: 8.0, left: 0.0, right: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  currentLoopData.artistImagePath),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Add SizedBox to move the text down
                                SizedBox(height: 10), // Adjust the height as needed
                                Text(
                                  currentLoopData.artistName,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 510.0, bottom: 0.0),
                child: SmallTag(
                  tags: currentLoopData.tags,
                  onDeleteTag: (index) {
                    print('Deleted tag at index: $index');
                  },
                ),
              ),
              // Icons Column
              Positioned(
                top: 425, // Adjust this value to move the icons lower
                right: 10,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    Text(
                      '${currentLoopData.comments}',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    Text(
                      '${currentLoopData.likes}',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.download),
                      onPressed: () {},
                    ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        currentLoopData.licensing,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    // Scrubber
                    Slider(
                      value: 0.5,
                      onChanged: (value) {},
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