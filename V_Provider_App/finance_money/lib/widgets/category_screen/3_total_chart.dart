import 'package:finance_money/database/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Todo: TotalChart
class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, database, __) {
        var list = database.categories;
        var total = database.calculateTotalExpenses();

        return Row(
          children: [
            Expanded(
              flex: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Total Expense: ${NumberFormat.currency(locale: 'en_IN', symbol: '\$').format(total)}',
                      textScaleFactor: 1.5,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...list.map(
                    (e) => Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                          const SizedBox(width: 5),
                          //Title
                          Text(e.title),
                          SizedBox(width: 5),
                          //totalAmount: tổng cộng
                          Text(
                            total == 0
                                ? '0%'
                                : '${((e.totalAmount / total) * 100).toStringAsFixed(2)}%',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 40,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 20,
                  sections: total != 0
                      ? list
                          .map((e) => PieChartSectionData(
                                showTitle: false,
                                value: e.totalAmount,
                                color: Colors.primaries[list.indexOf(e)],
                              ))
                          .toList()
                      : list
                          .map((e) => PieChartSectionData(
                                showTitle: false,
                                color: Colors.primaries[list.indexOf(e)],
                              ))
                          .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
