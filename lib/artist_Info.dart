import 'package:flutter/material.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180, 
      color: Colors.grey.withOpacity(0),
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Positioned(
            left: 32, 
            top: 32, 
            child: Container(
              width: 100, 
              height: 100, 
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/Ellipse 12 (1).png'), // Set the circular picture here
                  fit: BoxFit.cover,
                ),
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
                  "Kyler",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8), 
                Text(
                  "Marrero, LA",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.play_arrow, color: Colors.white), 
                    const SizedBox(width: 4), 
                    Text(
                      "1042",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 16), 
                    const Icon(Icons.favorite, color: Colors.white), 
                    const SizedBox(width: 4), 
                    Text(
                      "165",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8), 
                Text(
                  "Hi, i make too many loops, ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4), 
                Text(
                  "So i update them here",
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