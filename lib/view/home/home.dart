import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ticketerorganisers/theme/apptheme.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

/// Chart Sales Data
class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, [this.date, this.color]);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartSampleData>? chartData;

  @override
  void initState() {
   chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jan',
          y: 40,
          yValue: 0,
          secondSeriesYValue: 30,
          thirdSeriesYValue: 18),
      ChartSampleData(
          x: 'Feb',
         y: 45,
          yValue: 0,
          secondSeriesYValue: 24,
          thirdSeriesYValue: 12),
      ChartSampleData(
          x: 'Mar',
        y: 55,
          yValue: 0,
          secondSeriesYValue: 29,
          thirdSeriesYValue: 15),
      ChartSampleData(
          x: 'Apr',
         y: 56,
          yValue: 0,
          secondSeriesYValue: 24,
          thirdSeriesYValue: 10),
      ChartSampleData(
          x: 'May',
          y: 46,
          yValue: 0,
          secondSeriesYValue: 30,
          thirdSeriesYValue: 18),
      ChartSampleData(
          x: 'Jun',
          y: 49,
          yValue: 0,
          secondSeriesYValue: 24,
          thirdSeriesYValue: 10)
    ];
    super.initState();
  }

  List<SplineRangeAreaSeries<ChartSampleData, String>> _getSplineAreaSeries(
      bool isMaterial3, bool isLightMode) {
    final Color seriesColor1 = isMaterial3
        ? (isLightMode
            ?AppTheme.primaryColor 
            : const Color.fromRGBO(255, 245, 0, 1))
        : const Color.fromRGBO(75, 135, 185, 1);
    final Color seriesColor2 = isMaterial3
        ? (isLightMode
            ?Color.fromARGB(255, 100, 102, 103)
            : const Color.fromRGBO(51, 182, 119, 1))
        : const Color.fromRGBO(192, 108, 132, 1);
    return <SplineRangeAreaSeries<ChartSampleData, String>>[
      SplineRangeAreaSeries<ChartSampleData, String>(
        dataSource: chartData,
        color: seriesColor1.withOpacity(0.5),
      //  borderColor: seriesColor1,
      //  borderDrawMode: RangeAreaBorderMode.excludeSides,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        highValueMapper: (ChartSampleData sales, _) => sales.y,
        lowValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'Sales A',
      ),
      SplineRangeAreaSeries<ChartSampleData, String>(
        dataSource: chartData,
        borderColor: seriesColor2,
        color: seriesColor2.withOpacity(0.5),
        borderDrawMode: RangeAreaBorderMode.excludeSides,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        highValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        lowValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        name: 'Sales B',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
       SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Ticket Sales'),
      legend: const Legend(isVisible: true),
      primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 60,
          axisLine: AxisLine(width: 0),
          labelFormat: r'${value}',
          majorTickLines: MajorTickLines(size: 0)),
      series: _getSplineAreaSeries(
          Get.theme.useMaterial3, Get.theme.brightness == Brightness.light),
      tooltipBehavior: TooltipBehavior(enable: true),
    )
        // Container(
        //   height: 250,
        //   child: SfCircularChart(
        //       legend: Legend(isVisible: true, position: LegendPosition.bottom),
        //       tooltipBehavior: TooltipBehavior(enable: true),
        //       series: <CircularSeries>[
        //         // Render pie chart \\

        //         PieSeries<ChartData, String>(
        //             dataSource: [
        //               ChartData(
        //                 'Today',
        //                 30,
        //               ),
        //               ChartData('Weekly', 55),
        //               ChartData('Monthly', 200),
        //               ChartData('Yearly', 100),
        //             ],
        //             name: "Sales",
        //             enableTooltip: true,
        //             dataLabelSettings: DataLabelSettings(
        //                 isVisible: true,
        //                 labelPosition: ChartDataLabelPosition.outside),
        //             pointColorMapper: (ChartData data, _) => data.color,
        //             xValueMapper: (ChartData data, _) => data.x,
        //             yValueMapper: (ChartData data, _) => data.y)
        //       ]),
        //  ),
      ],
    ));
  }
}
