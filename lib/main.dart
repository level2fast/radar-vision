import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radar_vision/range_doppler_map_page.dart';
import 'package:radar_vision/range_angle_map_page.dart';
import 'package:radar_vision/radar_point_cloud_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Radar Vision App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var connected = false;
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void connectBle() {
    if (favorites.contains(current)) {
      connected = true;
      favorites.remove(current);
    } else {
      connected = false;
      favorites.add(current);
    }
    notifyListeners();
  }
}
// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // add stateful variables here
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ...

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ConnectPage();
        break;
      case 1:
        page = RangeDopplerMapPage();
        break;
      case 2:
        page = RangeAngleMapPage();
        break;
      case 3:
        page = RadarPointCloudPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

// ...
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.map),
                    label: Text('Range Doppler Map'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.text_rotation_angledown),
                    label: Text('Angle Plot'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.scatter_plot),
                    label: Text('Point Cloud Plot'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    var is_connected = appState.connected;
    var button_text = "CONNECT";
    if (is_connected) {
      // sets ble icon to blue
      // update button text to say paired
      button_text = "PAIRED";
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.connectBle();
                },
                icon: Icon(Icons.bluetooth),
                label: Text(button_text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: is_connected
                      ? Colors.lightBlueAccent
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
