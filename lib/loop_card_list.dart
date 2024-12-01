import 'package:flutter/material.dart';
import 'loopcard.dart';
import 'loop_files/loop_data.dart';

class LoopList extends StatelessWidget {
  final String name;
  final Color color;
  final List<LoopData> loopDataList;

  const LoopList({
    Key? key,
    required this.name,
    required this.color,
    required this.loopDataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0), // Outside container margin
      padding: const EdgeInsets.all(8.0), // Inside container padding
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Add padding to the text
            child: Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0, // Slightly smaller text size
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(8.0,4.0,8.0,0.0),
                  itemCount: loopDataList.length,
                  itemBuilder: (context, index) {
                    return LoopCard(loopData: loopDataList[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}