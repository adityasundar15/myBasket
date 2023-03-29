import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../chart_data.dart';
import './pie_details_list.dart';
import './change_budget.dart';

class ProfilePieCard extends StatefulWidget {
  final Function getPieData;

  const ProfilePieCard({required this.getPieData, super.key});

  @override
  State<ProfilePieCard> createState() => _ProfilePieCardState();
}

class _ProfilePieCardState extends State<ProfilePieCard> {
  void _showBudgetChanger(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
              onTap: null,
              behavior: HitTestBehavior.opaque,
              child: const ChangeBudgetDialog());
        }).then((value) {
      setState(() {
        // get the value entered from the modalBottomSheet and
        // change total budget here. It will reflect in the pie chart
        // which uses the value of totalBudget.
        totalBudget = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
      elevation: 4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 10, right: 10),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Monthly Budget',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 20, left: 10, right: 10),
                  child: IconButton(
                      onPressed: () => _showBudgetChanger(context),
                      icon: const Icon(Icons.edit)))
            ],
          ),
          SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                    sections: widget.getPieData(totalBudget),
                    centerSpaceRadius: 0),
              )),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'You\'ve used \$${getAmountForMonth(DateTime.now().month)} out of \$$totalBudget.'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PieDetailsList.routeName);
                    },
                    child:
                        const Text('Details >', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
