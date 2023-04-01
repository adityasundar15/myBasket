import 'package:flutter/material.dart';

//The color scheme used for the project
import 'colorScheme.dart';

import './screens/alert_list.dart';
import './screens/bottom_nav_screen.dart';
import './widgets/profilePage/pie_details_list.dart';
import './widgets/profilePage/bar_details_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
          primarySwatch: ColorOptions.colorscheme, //using the color scheme
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: ColorOptions.colorscheme),
      home: const TabScreen(),
      routes: {
        AlertList.routeName: (context) => const AlertList(),
        PieDetailsList.routeName: (context) => const PieDetailsList(),
        BarDetailsList.routeName: (context) => const BarDetailsList()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
