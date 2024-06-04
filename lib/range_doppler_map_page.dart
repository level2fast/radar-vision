import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RangeDopplerMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: NumericAxis(
                      maximum: -10,
                      minimum: 10,
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
                      maximum: 22.5,
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
                    series: <ScatterSeries<TargetData, double>>[
          ScatterSeries<TargetData, double>(
              // Bind data source
              dataSource: <TargetData>[
                TargetData(0, 5),
                TargetData(1, 8),
                TargetData(2, 4),
                TargetData(3, 2),
                TargetData(4, 0)
              ],
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
