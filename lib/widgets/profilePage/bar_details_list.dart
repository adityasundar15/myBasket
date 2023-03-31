import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/chart_data.dart';
import '../../colorScheme.dart';

class BarDetailsList extends StatelessWidget {
  const BarDetailsList({super.key});
  static const routeName = '/bar-details-list';

  Widget displayAllYearlyTransactions() {
    return SizedBox(
      height: 750,
      child: ListView.builder(
        itemCount: yearlyTransactions.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Card(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: ColorOptions.colorscheme[900]!),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat.MMMM().format(DateTime(0, index + 1))}: ',
                      style: TextStyle(
                          color: ColorOptions.colorscheme[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('\$${yearlyTransactions[index]}',
                        style: TextStyle(
                            color: ColorOptions.colorscheme[800],
                            fontSize: 18,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Year Overview',
          style: TextStyle(fontSize: 28),
        ),
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [displayAllYearlyTransactions()],
      ),
    );
  }
}
