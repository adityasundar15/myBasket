import 'package:flutter/material.dart';

//The color scheme used for the project
import 'colorScheme.dart';

import './screens/alert_list.dart';
import './screens/bottom_nav_screen.dart';
import './widgets/profilePage/pie_details_list.dart';

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
        // BarDetailsList.routeName: (context) => const BarDetailsList()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   //list of classes from the three pages for navbar
//   static final List<Widget> _widgetOptions = <Widget>[
//     homePage(),
//     const ShoppingList(),
//     const ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 10,
//               offset: const Offset(0, -1),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           elevation: 8,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart),
//               label: 'Shopping List',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: ColorOptions.colorscheme[800]!,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
