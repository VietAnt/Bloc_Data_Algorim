import 'package:finance_money/database/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Todo: ExpenseChart
class ExpenseChart extends StatefulWidget {
  final String category;

  const ExpenseChart(this.category, {super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, database, __) {
        var maxY =
            database.calculateEntriesAndAmount(widget.category)['totalAmount'];
        var list = database.calculateWeekExpenses().reversed.toList();

        return BarChart(
          BarChartData(
            minY: 0,
            maxY: maxY,
            barGroups: [
              ...list.map(
                (e) => BarChartGroupData(
                  x: list.indexOf(e),
                  barRods: [
                    BarChartRodData(
                      toY: e['amount'],
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
              )
            ],
            titlesData: FlTitlesData(
              topTitles: AxisTitles(
                drawBehindEverything: true,
              ),
              leftTitles: AxisTitles(
                drawBehindEverything: true,
              ),
              rightTitles: AxisTitles(
                drawBehindEverything: true,
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    return Text(
                      DateFormat.E().format(list[value.toInt()]['day']),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
