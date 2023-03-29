import 'package:flutter/material.dart';
import './alert_list.dart';

import 'package:table_calendar/table_calendar.dart';

import '../models/item.dart';
import '../myUtils.dart';
import '../widgets/stockPage/stock_item_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Expiry dates',
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Icon(Icons.calendar_month),
                  Container(
                    margin: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     border: Border.all(color: Colors.purple)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AlertList.routeName);
                        },
                        icon: Icon(
                          size: 32,
                          Icons.warning_amber,
                          color: Colors.amber[700],
                        )),
                  ),
                ],
              )
            ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
