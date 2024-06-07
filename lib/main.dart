import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radar_vision/range_doppler_map_page.dart';
import 'package:radar_vision/range_angle_map_page.dart';
import 'package:radar_vision/coordinates_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  double _x = 0.0;
  double get x => _x;

  double _y = 0.0;
  double get y => _y;

  double _z = 0.0;
  double get z => _z;

  void setCoordinates(double xval, double yval, double zval) {
    _x = xval;
    _y = yval;
    _z = zval;
    // notifyListeners();
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
        page = RangeDopplerMapPage();
        break;
      // case 1:
      //   page = RangeAngleMapPage();
      //   break;
      case 1:
        page = SensorData();
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
                    icon: Icon(Icons.map),
                    label: Text('Range Doppler Map'),
                  ),
                  // NavigationRailDestination(
                  //   icon: Icon(Icons.text_rotation_angledown),
                  //   label: Text('Angle Plot'),
                  // ),
                  NavigationRailDestination(
                    icon: Icon(Icons.scatter_plot),
                    label: Text('Sensor Data'),
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
