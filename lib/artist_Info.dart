import 'package:flutter/material.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, 
      //color: Colors.grey.withOpacity(0.1),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage('https://www.pixelstalk.net/wp-content/uploads/2016/07/3840x2160-Images-Free-Download.jpg'),
            opacity: 0.3,
            fit: BoxFit.cover, // Adjust how the image fits the box
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 32, 
            top: 32, 
            child: Container(
              width: 96, 
              height: 96, 
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 32 + 96 + 24, 
            top: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Artist Name",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8), 
                Text(
                  "Where From",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white), 
                    const SizedBox(width: 4), 
                    Text(
                      "104,012",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 16), 
                    const Icon(Icons.favorite, color: Colors.white), 
                    const SizedBox(width: 4), 
                    Text(
                      "5004",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8), 
                Text(
                  "Max 2 lines, making it long",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4), 
                Text(
                  "2 lined test string",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}