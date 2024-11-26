// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_super_parameters

import 'dart:math';
import 'package:flutter/material.dart';

/// Model class representing a Loop object
class Loop {
  final String title;
  final String subtitle;
  final String imageUrl;

  Loop({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class LoopCard extends StatefulWidget {
  final Loop loop;

  const LoopCard({
    Key? key,
    required this.loop,
  }) : super(key: key);

  @override
  _LoopCardState createState() => _LoopCardState();
}

class _LoopCardState extends State<LoopCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  int _likeCount = 0;
  int _dislikeCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        height:
            _isExpanded ? 425.0 : 87.0, // Expands or collapses based on state
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(110, 100, 100, 0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),

        // Add a Row with three Column children
        child: Row(
          children: [

            Column(
              children: [
                Container(
                  height: 71.0,
                  width: 67.0,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.loop.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      widget.loop.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: _isExpanded ? null : 1,
                      overflow: _isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      widget.loop.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),

            //like and dislike feature
            Column(
              children: [
                Container(
                  width: 51.0,
                  height: 24.0,
                  margin: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                  color: Colors.white.withOpacity(0.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 2.0, bottom: 4.0, right: 1.5, left: 3.0),
                        width: 21.0,
                        height: 18.0,
                        color: Colors.white.withOpacity(0.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: 20.0,
                          icon: Icon(
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
                        margin: EdgeInsets.only(
                            top: 2.0, bottom: 4.0, right: 3.0, left: 1.5),
                        width: 21.0,
                        height: 18.0,
                        color: Colors.white.withOpacity(0.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: 20.0,
                          icon: Icon(
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
                    const SizedBox(
                      width: 3.0,
                    ),
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
                  margin: EdgeInsets.only(right: 8.0, left: 8.0),
                  color: Colors.white.withOpacity(0.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 3.0, bottom: 3.0, right: 1.5, left: 3.0),
                        width: 21.0,
                        height: 21.0,
                        color: Colors.white.withOpacity(0.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 3.0, bottom: 3.0, right: 3.0, left: 1.5),
                        width: 21.0,
                        height: 21.0,
                        color: Colors.white.withOpacity(0.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          iconSize: 20.0,
                          icon: Icon(
                            Icons.comment,
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
                Row(
                  children: [
                    Container(
                      height: 12.0,
                      width: 21.0,
                      color: Colors.white.withOpacity(0.0),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
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

              ],
            ),
          ],
        ),
      ),
    );
  }
}
