import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

double totalBudget = 200.0;

final List<Transaction> allTransactions = [
  Transaction(dateOfTransaction: DateTime(2023, 1, 17), amount: 30.0),
  Transaction(dateOfTransaction: DateTime(2023, 2, 17), amount: 40.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 3), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 3), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 19), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 29), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 30), amount: 50.0),
  Transaction(dateOfTransaction: DateTime(2023, 4, 3), amount: 50.0),
  Transaction(dateOfTransaction: DateTime(2023, 4, 5), amount: 50.0),
  Transaction(dateOfTransaction: DateTime(2023, 4, 17), amount: 50.0),
  Transaction(dateOfTransaction: DateTime(2023, 5, 17), amount: 10.0),
];

double getAmountForMonth(int kmonth) {
  double amt = 0;
  allTransactions.forEach((element) {
    if (element.dateOfTransaction.month == kmonth) {
      amt += element.amount;
    }
  });
  return amt;
}

Map<int, double> getYearlyTransactions() {
  Map<int, double> trans = {};
  for (int i = 0; i < 12; i++) {
    trans[i] = getAmountForMonth(i + 1);
  }
  return trans;
}

Map<int, double> yearlyTransactions = getYearlyTransactions();

// Map<int, double> yearlyTransactions = getYearlyTransactions();
// print(yearlyTransactions)

final double barWidth = 12;

// pie data moved to profile screen
List<PieChartSectionData> givePieData(double totalBudget) {
  double amountSpentThisMonth = getAmountForMonth(DateTime.now().month);
  return [
    PieChartSectionData(
        value: amountSpentThisMonth,
        title: '',
        color: Colors.purple,
        radius: 100),
    PieChartSectionData(
        value: totalBudget - amountSpentThisMonth,
        title: '',
        color: Colors.grey[300],
        radius: 100)
  ];
}

List<BarChartGroupData> getBarData() {
  List<BarChartGroupData> myData = [];
  for (int i = 0; i < 12; i++) {
    myData.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              toY: yearlyTransactions[i] ?? 0,
              width: barWidth,
              borderRadius: BorderRadius.zero)
        ],
      ),
    );
  }
  return myData;
}

List<BarChartGroupData> barData = getBarData();

// final List<BarChartGroupData> barData = [
//   BarChartGroupData(
//     x: 0,
//     barRods: [
//       BarChartRodData(
//           toY: yearlyTransactions[1],
//           width: barWidth,
//           borderRadius: BorderRadius.zero)
//     ],
//   ),
//   BarChartGroupData(x: 1, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 2, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 3, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 4, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 5, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 6, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 7, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 8, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 9, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 10, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 11, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
//   BarChartGroupData(x: 12, barRods: [
//     BarChartRodData(toY: 10, width: barWidth, borderRadius: BorderRadius.zero)
//   ]),
// ];
