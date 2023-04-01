import 'package:flutter/material.dart';
import './alert_list.dart';

import 'package:table_calendar/table_calendar.dart';

import '../models/item.dart';
import '../myUtils.dart';
import '../widgets/stockPage/stock_item_list.dart';

//The color scheme used for the project
import '../colorScheme.dart';

import '../widgets/stockPage/add_item.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  // late ValueNotifier<List<MyEvent>> _selectedEvents;
  late ValueNotifier<List<Item>> _selectedItems;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDate;
    _selectedItems = ValueNotifier(_getItemsForDay(_selectedDate!));
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    if (!isSameDay(_selectedDate, selectedDate)) {
      setState(() {
        _focusedDate = focusedDate;
        _selectedDate = selectedDate;
      });
      _selectedItems.value = _getItemsForDay(selectedDate);
    }
  }

  List<Item> _getItemsForDay(DateTime date) {
    return kItems[date] ?? [];
  }

  void showAddItem(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
              onTap: null,
              behavior: HitTestBehavior.opaque,
              // display what should be inside the modal sheet.
              child: const AddItemDialog());
        }).then((data) {
      if (!kItems.keys.contains(data.expiryDate)) {
        kItems[data.expiryDate] = [];
      }
      setState(() {
        kItems[data.expiryDate]?.add(data);
        // print(kItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AlertList.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     border: Border.all(color: Colors.purple)),
                    child: Icon(
                      size: 28,
                      Icons.warning_amber,
                      color: ColorOptions.colorscheme[50],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Expiry alerts',
                      style: TextStyle(
                          fontSize: 24, color: ColorOptions.colorscheme[50]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TableCalendar<Item>(
            focusedDay: _focusedDate,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDate) {
              _focusedDate = focusedDate;
            },
            eventLoader: _getItemsForDay,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: ColorOptions.colorscheme[500]!,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                  color: ColorOptions.colorscheme[300]!,
                  shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Item>>(
              valueListenable: _selectedItems,
              builder: (context, value, _) {
                return StockItemList(itemList: value);
              },
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItem(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
