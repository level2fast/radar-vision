import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:radar_vision/main.dart';

class SensorData extends StatefulWidget {
  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  var x = "0";
  var y = "0";
  var z = "0";
  @override
  void initState() {
    init();
    setListener();
    super.initState();
  }

  void init() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('SensorData').get();
    if (snapshot.exists) {
      // print(snapshot.value);
      setState(() {
        x = snapshot.child("x").value.toString();
        y = snapshot.child("y").value.toString();
        z = snapshot.child("z").value.toString();
      });
    } else {
      print('No data available.');
    }
  }

  void setListener() {
    DatabaseReference sensor = FirebaseDatabase.instance.ref('SensorData');
    sensor.onValue.listen((DatabaseEvent event) {
      x = event.snapshot.child("x").value.toString();
      y = event.snapshot.child("y").value.toString();
      z = event.snapshot.child("z").value.toString();
    });
  }

  // void update() {
  //   MyAppState()
  //       .setCoordinates(double.parse(x), double.parse(y), double.parse(z));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('X Value: $x'),
            Text('Y Value: $y'),
            Text('Z Value: $z'),
          ],
        ),
      ),
    );
  }
}
