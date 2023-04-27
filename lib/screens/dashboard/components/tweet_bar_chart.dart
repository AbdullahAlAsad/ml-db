import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TweetBarChart extends StatelessWidget {
  final Map<String, int> tweetCountByMonth;

  TweetBarChart({required this.tweetCountByMonth});

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barChartData = [];

    int index = 0;
    tweetCountByMonth.forEach((month, count) {
      barChartData.add(BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: count.toDouble(),
            colors: [Colors.blue],
            width: 20,
          ),
        ],
        showingTooltipIndicators: [0],
      ));
      index++;
    });

    return BarChart(
      BarChartData(
        barGroups: barChartData,
        barTouchData: BarTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            fitInsideVertically: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                // tweetCountByMonth.keys.elementAt(group.x.toInt()) +
                //     ': ' +
                    rod.y.toInt().toString(),
                TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context,value) => const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            getTitles: (double value) {
              return tweetCountByMonth.keys.elementAt(value.toInt());
            },
            margin: 4,
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround
      ),
    );
  }
}
