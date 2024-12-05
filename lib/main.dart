import 'package:animations/animations.dart';
import 'package:bestloop_app/loop_files/loop_data_dictionary.dart';
import 'package:bestloop_app/pages/discover_page.dart';
import 'package:bestloop_app/debug.dart';
import 'package:bestloop_app/pages/create_page.dart';
import 'package:bestloop_app/pages/leaderboard_page.dart';
import 'package:bestloop_app/pages/search_page.dart';
import 'package:bestloop_app/pages/sign_in.dart';
// import 'package:bestloop_app/pages/create_page.dart';
// import 'package:bestloop_app/pages/discover_page.dart';
// import 'package:bestloop_app/pages/leaderboard_page.dart';
// import 'package:bestloop_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'pages/sign_in.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(WidgetsApp(
    color: Colors.black12,
    builder: (context, child) {return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp());},
    ));
}

/*
  "ColorScheme.surface" is to be used to refer to the background color!
  "TextTheme.bodySmall" is for Tag text.
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      checkerboardOffscreenLayers: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          brightness: Brightness.dark,
          surface: const Color(0),
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            height: 1.0,
          ),  // USED FOR TAGS
          bodyMedium: TextStyle(
            fontSize: 12, 
            height: 1.0,
            color: const Color(0xFFFFFFFF).withOpacity(.6)
          ),
          bodyLarge: const TextStyle(
            fontSize: 16,
            height: 1.0,
            color: Color(0xFFFFFFFF)
          ),
          displayMedium: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            height: 1.0,
          )
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: Colors.transparent,
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.grey);
          }),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(color: Colors.white);
            }
            return const TextStyle(color: Colors.grey);
          }),
        ),
      ),
      home: GlobalScaffold(title: "Home",key: globalScaffoldKey,),
    );
  }
}

final GlobalKey<_GlobalScaffoldState> globalScaffoldKey = GlobalKey<_GlobalScaffoldState>();
/// This is the scaffold which contains the icons TODO: Add better documentation
class GlobalScaffold extends StatefulWidget {
  const GlobalScaffold({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<GlobalScaffold> createState() => _GlobalScaffoldState();
}

class _GlobalScaffoldState extends State<GlobalScaffold> {
  int currentPageIndex = 0;
  ValueNotifier<String> currentSelectedLoop = ValueNotifier("");

  void updatePageIndex(int newIndex) {
    setState(() {
      currentPageIndex = newIndex;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 64,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.grey.shade900,
        indicatorColor: Colors.transparent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.leaderboard),
            icon: Icon(Icons.leaderboard_outlined),
            label: 'Leaderboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bolt),
            icon: Icon(Icons.bolt_outlined), //TODO: The icon here is broken and needs changing.
            label: 'Discover',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.upload_rounded),
            icon: Icon(Icons.upload_outlined),
            label: 'Create',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.upload_rounded),
          //   icon: Icon(Icons.upload_outlined),
          //   label: 'Search',
          // ),
        ],
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: <Widget>[
          LeaderboardPage(),
          DiscoverPage(),
          ProfilePage(),
          CreatePage(),
          SearchPage(),
        ][currentPageIndex],
      ),
    );
    //);
  }
}