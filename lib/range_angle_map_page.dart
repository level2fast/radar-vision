import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

late SelectionBehavior _selectionBehavior;

class RangeAngleMapPage extends StatelessWidget {
  void initState() {
    _selectionBehavior = SelectionBehavior(
        enable: true,
        selectedColor: Colors.green,
        unselectedColor: Colors.grey,
        toggleSelection: true,
        selectedBorderWidth: 4,
        selectedBorderColor: Colors.black,
        unselectedBorderColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    initState();
    final List<ChartData> chartData = [
      ChartData('-90° <=> -30°', 60, 1, Colors.grey),
      ChartData('-30° <=> 30°', 60, 2, Colors.grey),
      ChartData('60° <=> 90°', 60, 3, Colors.grey)
    ];
    // check the state of the incoming packet
    // if it's  in region 1 set color to green
    // else if its in region 2 set color to green
    // else if in region 3 set color to green
    // else if it's not in any region set color to grey

    return Scaffold(
        body: Center(
            child: Container(
                child: SfCircularChart(
                    enableMultiSelection: true,
                    borderColor: Colors.black,
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(child: const Text('0 deg')),
                          radius: '0%',
                          verticalAlignment: ChartAlignment.near,
                          horizontalAlignment: ChartAlignment.center),
                      CircularChartAnnotation(
                          widget: Container(child: const Text('90 deg')),
                          radius: '100%',
                          verticalAlignment: ChartAlignment.center,
                          horizontalAlignment: ChartAlignment.center),
                      CircularChartAnnotation(
                        widget: Container(
                          child: const Text(
                              '-90 deg                                                                                               '),
                        ),
                      )
                    ],
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
                    series: <PieSeries>[
                      PieSeries<ChartData, String>(
                          strokeColor: Colors.black,
                          strokeWidth: 2,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          pointColorMapper: (ChartData data, _) => data.color,
                          selectionBehavior: _selectionBehavior,
                          // starting angle of pie
                          startAngle: 270,
                          // ending angle of pie
                          endAngle: 90)
                    ]))));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.index, [this.color]);
  final String x;
  final double y;
  final int index;
  final Color? color;
}
