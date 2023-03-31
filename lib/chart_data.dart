import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

import '/colorScheme.dart'; //Color scheme of project

double totalBudget = 200.0;

List<Transaction> allTransactions = [
  Transaction(dateOfTransaction: DateTime(2023, 1, 17), amount: 30.0),
  Transaction(dateOfTransaction: DateTime(2023, 2, 17), amount: 40.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 3), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 3), amount: 20.0),
  Transaction(dateOfTransaction: DateTime(2023, 3, 19), amount: 20.0),
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

const double barWidth = 12;

// pie data moved to profile screen
List<PieChartSectionData> givePieData(double totalBudget) {
  double amountSpentThisMonth = getAmountForMonth(DateTime.now().month);
  return [
    PieChartSectionData(
        value: amountSpentThisMonth,
        title: '',
        color: ColorOptions.colorscheme[900],
        radius: 100),
    PieChartSectionData(
        value: totalBudget - amountSpentThisMonth,
        title: '',
        color: ColorOptions.colorscheme[100],
        radius: 100)
  ];
}

List<BarChartGroupData> getBarData() {
  List<BarChartGroupData> myData = [];
  // update the yearly transactions
  yearlyTransactions = getYearlyTransactions();
  for (int i = 0; i < 12; i++) {
    myData.add(
      BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
              color: ColorOptions.colorscheme[500],
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
