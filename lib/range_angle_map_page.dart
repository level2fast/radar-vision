import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RangeAngleMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('60 degrees', 60),
      ChartData('60 degrees', 60),
      ChartData('60 degrees', 60)
    ];
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        // Border color and border width of legend
                        borderColor: Colors.black,
                        borderWidth: 2),
                    title: ChartTitle(
                        text: 'Angle Plot',
                        // Aligns the chart title to left
                        alignment: ChartAlignment.center,
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        )),
                    series: <CircularSeries>[
          PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // starting angle of pie
              startAngle: 270,
              // ending angle of pie
              endAngle: 90)
        ]))));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
