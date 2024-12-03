import 'dart:io';
import 'dart:math';
import 'package:bestloop_app/components/waveform.dart';
import 'package:bestloop_app/main.dart';
import 'package:bestloop_app/pages/discover_page.dart';
import 'package:bestloop_app/pages/search_page.dart';
import 'package:bestloop_app/sound_services/loop_sound_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'loop_files/loop_data.dart';
import 'components/tag_widget.dart';

const discoverPageIndex = 1;

class LoopCard extends StatefulWidget {
  final LoopData loopData;

  const LoopCard({
    Key? key,
    required this.loopData,
  }) : super(key: key);

  @override
  _LoopCardState createState() => _LoopCardState();
}

class _LoopCardState extends State<LoopCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late int _likeCount;
  late int _dislikeCount;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.loopData.likes;
    _dislikeCount = widget.loopData.dislikes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        if (_isExpanded) {
          LoopSoundService.changeLoop(widget.loopData.audioPath);
          LoopSoundService.playLoop();
        } else {
          if (SearchPage.isActive) {
            Navigator.pop(context);
          }
          globalScaffoldKey.currentState?.updatePageIndex(discoverPageIndex);
        }
      
      },
      child: AnimatedContainer(
        height: _isExpanded ? 170.0 : 89.0,
        duration: const Duration(milliseconds: 250), // Faster animation
        curve: Curves.ease,
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0x44FF008C),Color(0x44B500B5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: _isExpanded ? const Color(0xFF4A004A) : const Color.fromARGB(255, 120, 2, 120).withOpacity(.6), // Less vibrant colors
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            width: 1.0,
            color: widget.loopData.hasBeenOnLeaderboard ? Colors.yellow.withOpacity(0.6) : Colors.yellow.withOpacity(0),
          ),
        ),
        /* Wrapping the contents in a scroll view suppresses the overflow warning. This is intended
        because the content is meant to overflow during the expanding part of the animation. */
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 71.0,
                        width: 67.0,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: widget.loopData.imagePath.startsWith('assets/')
                                ? AssetImage(widget.loopData.imagePath)
                                : FileImage(File(widget.loopData.imagePath)) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 33.0),
                          child: AnimatedOpacity(
                            opacity: _isExpanded ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: SineWaveRectangles(isSmall: true,),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                widget.loopData.loopTitle,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: _isExpanded ? null : 1,
                                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    widget.loopData.artistName,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 4.0),
                                  const Text(
                                    '•',
                                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Expanded(
                                    child: Text(
                                      widget.loopData.location,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // Ensure text does not overflow
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            SmallTag(
                              tags: widget.loopData.tags,
                              maxTagViewHeight: _isExpanded ? 36 : 16,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 51.0,
                            height: 24.0,
                            margin: const EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
                            color: Colors.white.withOpacity(0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(height: 24),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2.0, bottom: 4.0, right: 1.5, left: 3.0),
                                    width: 21.0,
                                    height: 18.0,
                                    color: Colors.white.withOpacity(0.0),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      iconSize: 20.0,
                                      icon: const Icon(
                                        Icons.arrow_upward_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _likeCount++;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2.0, bottom: 4.0, right: 3.0, left: 1.5),
                                    width: 21.0,
                                    height: 18.0,
                                    color: Colors.white.withOpacity(0.0),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      iconSize: 20.0,
                                      icon: const Icon(
                                        Icons.arrow_downward_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _dislikeCount++;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                height: 12.0,
                                width: 21.0,
                                color: Colors.white.withOpacity(0.0),
                                child: Center(
                                  child: Text(
                                    '$_likeCount',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3.0),
                              Container(
                                height: 12.0,
                                width: 21.0,
                                color: Colors.white.withOpacity(0.0),
                                child: Center(
                                  child: Text(
                                    '$_dislikeCount',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 51.0,
                            height: 24.0,
                            margin: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
                            color: Colors.white.withOpacity(0.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 20.0,
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Add comment functionality here
                              },
                            ),
                          ),
                          if (_isExpanded)
                            Container(
                              height: 12.0,
                              width: 51.0,
                              color: Colors.white.withOpacity(0.0),
                              child: Center(
                                child: Text(
                                  '${widget.loopData.comments}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (_isExpanded)
                            Container(
                              width: 51.0,
                              height: 24.0,
                              margin: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
                              color: Colors.white.withOpacity(0.0),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20.0,
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Add share functionality here
                                },
                              ),
                            ),
                          if (_isExpanded)
                            Container(
                              width: 51.0,
                              height: 24.0,
                              margin: const EdgeInsets.only(right: 16.0, left: 16.0, top: 8.0),
 color: Colors.white.withOpacity(0.0),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20.0,
                                icon: Icon(
                                  Icons.download,
                                  color: widget.loopData.licensing == 'noshare' ? Colors.grey : Colors.white,
                                ),
                                onPressed: widget.loopData.licensing == 'noshare' ? null : () {
                                  // Add download functionality here
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 8.0,
                top: 87.0,
                child: SvgPicture.asset(
                  widget.loopData.licensing,
                  height: 20.0,
                  alignment: Alignment.centerLeft,
                ),
              ),
              if (_isExpanded)
                Positioned(
                  right: 80.0,
                  top: 120.0,
                  child: Container(
                    width: 230.0,
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 12.0,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            widget.loopData.topComment,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}