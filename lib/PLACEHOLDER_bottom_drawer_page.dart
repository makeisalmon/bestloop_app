import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomDrawerPage(),
    );
  }
}

class BottomDrawerPage extends StatefulWidget {
  @override
  _BottomDrawerPageState createState() => _BottomDrawerPageState();
}

class _BottomDrawerPageState extends State<BottomDrawerPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 10),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start from the bottom (fully hidden)
      end: Offset(0, 0), // End at the normal position (fully visible)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void toggleDrawer() {
    if (_isDrawerOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Drawer Example"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: toggleDrawer,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(child: Text("Main content goes here")),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300, // The height of the bottom drawer
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Option 1', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle action for Option 1
                      },
                    ),
                    ListTile(
                      title: Text('Option 2', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle action for Option 2
                      },
                    ),
                    ListTile(
                      title: Text('Option 3', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        // Handle action for Option 3
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
