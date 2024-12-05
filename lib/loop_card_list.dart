// 

import 'package:flutter/material.dart';
import 'loopcard.dart';
import 'loop_files/loop_data.dart';

class LoopList extends StatefulWidget {
  final String name;
  final List<Color> gradientColors;
  final List<LoopData> loopDataList;

  const LoopList({
    Key? key,
    required this.name,
    required this.gradientColors,
    required this.loopDataList,
  }) : super(key: key);

  @override
  _LoopListState createState() => _LoopListState();
}

class _LoopListState extends State<LoopList> {
  final List<LoopData> _loadedLoops = [];
  int _currentBatchIndex = 0;
  final int _batchSize = 1;

  @override
  void initState() {
    super.initState();
    _loadNextBatch();
  }

  void _loadNextBatch() async {
    await Future.delayed(Duration(milliseconds: 2));
    final nextBatch = widget.loopDataList
        .skip(_currentBatchIndex * _batchSize)
        .take(_batchSize)
        .toList();
    if (nextBatch.isNotEmpty) {
      setState(() {
        _loadedLoops.addAll(nextBatch);
        _currentBatchIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentBatchIndex * _batchSize < widget.loopDataList.length) {
      _loadNextBatch();
    }
    return Container(
      margin: const EdgeInsets.all(0.0), // Outside container margin
      padding: const EdgeInsets.all(8.0), // Inside container padding
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 0, 4), // Add padding to the text
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0, // Slightly smaller text size
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Column(
                children: [
                  for (var loop in _loadedLoops)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: LoopCard(loopData: loop),
                    ),
                  if (_currentBatchIndex * _batchSize < widget.loopDataList.length)
                    ElevatedButton(
                      onPressed: _loadNextBatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF202020),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Load More'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
