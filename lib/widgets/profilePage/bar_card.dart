import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../chart_data.dart';

class ProfileBarCard extends StatelessWidget {
  final List<BarChartGroupData> data;

  const ProfileBarCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    double getMaxVal() {
      var thevalue = 0.0;
      var thekey;

      yearlyTransactions.forEach((k, v) {
        if (v > thevalue) {
          thevalue = v;
          thekey = k;
        }
      });
      return thevalue + 10;
    }

    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 4,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Yearly Overview',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
                height: 200,
                width: 325,
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                    borderData: FlBorderData(
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        right: BorderSide.none,
                        top: BorderSide.none,
                      ),
                    ),
                    gridData: FlGridData(
                      show: false,
                    ),
                    maxY: getMaxVal(),
                    barGroups: data,
                    alignment: BarChartAlignment.spaceAround,
                  ),
                )),
          ),
          // Container(
          //     width: double.infinity,
          //     alignment: Alignment.centerRight,
          //     padding: const EdgeInsets.all(10),
          //     child: TextButton(
          //       onPressed: null,
          //       child: Text('Details >', style: TextStyle(fontSize: 18)),
          //     ))
        ],
      ),
    );
  }
}
