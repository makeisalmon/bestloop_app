import 'package:bestloop_app/debug.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          brightness: Brightness.dark,
          surface: const Color(0)
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall: const TextStyle(
            fontSize: 8,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
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
        )
      ),
      home: const DebugPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height:256,
              color: Color(0xFF232323),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Header Text',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    'This is a static, fixed-height area for testing widgets.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Expanded( // Forces widget to take up remaining screen space
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text("Bolded Header",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("This is a scrollable space for testing widgets.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9000, width: 128,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
