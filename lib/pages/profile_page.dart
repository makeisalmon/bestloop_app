import 'package:flutter/material.dart';
import '../artist_info.dart';
import '../loop_card_list.dart';
import '../loop_files/loop_data.dart';
import '../loop_files/loop_data_dictionary.dart'; // Import the dictionary

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _activeTab = "Favorites";

  void _setActiveTab(String tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image taking more space
        Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/IMG_6694 (1).jpg'), // Replace with your image asset
              fit: BoxFit.cover,
              opacity: .6, // Set opacity to 1 for the image to be fully visible
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent, // Start with no color (transparent) at the top
                  Colors.black, // Fade to black at the bottom with opacity
                ],
                stops: [0.0, .8], // Controls the transition area of the gradient
              ),
            ),
          ),
        ),          // Content
          Column(
            children: [
              const SizedBox(height: 50), // Add some top padding
              const ArtistInfo(),
              const SizedBox(height: 8), // Space between sections
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTagButton("Favorites", _activeTab == "Favorites", () => _setActiveTab("Favorites"), const Color(0xFF6100B5)),
                    _buildTagButton("Uploads", _activeTab == "Uploads", () => _setActiveTab("Uploads"), const Color(0xFFB500B5)),
                    _buildTagButton("Following", _activeTab == "Following", () => _setActiveTab("Following"), const Color(0xFF8B00B5)),
                  ],
                ),
              ),
              const SizedBox(height: 8), // Space between buttons and content
              Expanded(
                child: Column(
                  children: [
                    if (_activeTab == "Favorites")
                      Expanded(
                        child: LoopList(
                          name: "Favorites",
                          color: const Color(0xFF6100B5),
                          loopDataList: loopDataDictionary.values.toList(),
                        ),
                      ),
                    if (_activeTab == "Uploads")
                      Expanded(
                        child: LoopList(
                          name: "Uploads",
                          color: const Color(0xFFB500B5),
                          loopDataList: loopDataDictionary.values.toList(),
                        ),
                      ),
                    if (_activeTab == "Following")
                      Expanded(
                        child: LoopList(
                          name: "Following",
                          color: const Color(0xFF8B00B5),
                          loopDataList: loopDataDictionary.values.toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagButton(String text, bool isActive, VoidCallback onPressed, Color color) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isActive ? color : const Color(0xFF340022),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}