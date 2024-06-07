import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';

late TooltipBehavior _tooltipBehavior;
late ZoomPanBehavior _zoomPanBehavior;
double seriesAnimation = 1500;

class RangeDopplerMapPage extends StatefulWidget {
  @override
  State<RangeDopplerMapPage> createState() => _RangeDopplerMapPage();
}

class _RangeDopplerMapPage extends State<RangeDopplerMapPage> {
// class RangeDopplerMapPage extends StatelessWidget {
  double x = 0;
  double y = 0;
  double z = 0;

  double x_plot = 0;
  double y_plot = 0;
  double z_plot = 0;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, shouldAlwaysShow: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    init();
    setListener();
    super.initState();
  }

  void init() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('SensorData').get();
    if (snapshot.exists) {
      print(snapshot.value);

      x = double.parse(snapshot.child("x").value.toString());
      y = double.parse(snapshot.child("y").value.toString());
      z = double.parse(snapshot.child("z").value.toString());
      setState(() {
        x_plot = x;
        y_plot = y;
        z_plot = z;
      });
    } else {
      print('No data available.');
    }
  }

  void setListener() {
    DatabaseReference sensor = FirebaseDatabase.instance.ref('SensorData');
    sensor.onValue.listen((DatabaseEvent event) {
      x = double.parse(event.snapshot.child("x").value.toString());
      y = double.parse(event.snapshot.child("y").value.toString());
      z = double.parse(event.snapshot.child("z").value.toString());
      setState(() {
        x_plot = x;
        y_plot = y;
        z_plot = z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    zoomPanBehavior: _zoomPanBehavior,
                    // Initialize category axis
                    primaryXAxis: NumericAxis(
                      interval: 0.2,
                      maximum: -8,
                      minimum: 8,
                      title: AxisTitle(
                          text: 'Velocity(meters/sec)',
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800)),
                    ),
                    primaryYAxis: NumericAxis(
                      interval: 0.2,
                      maximum: 9,
                      minimum: 0,
                      title: AxisTitle(
                          text: 'Range(meters)',
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w800)),
                    ),
                    // Chart title
                    title: ChartTitle(text: 'Range vs. Velocity'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    series: <ScatterSeries<TargetData, double>>[
          ScatterSeries<TargetData, double>(
              enableTooltip: true,
              // Bind data source
              dataSource: <TargetData>[TargetData(y_plot, x_plot)],
              xValueMapper: (TargetData target, _) => target.range,
              yValueMapper: (TargetData target, _) => target.velocity)
        ]))));
  }
}

class TargetData {
  TargetData(this.range, this.velocity);
  final double range;
  final double velocity;
}
