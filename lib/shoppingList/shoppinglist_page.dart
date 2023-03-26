import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '/colorScheme.dart';
import 'db_helper.dart';
import 'shopping_item.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<ShoppingItem> _shoppingItems = [];
  late Future<List<ShoppingItem>> _shoppingItemsFuture;

  int itemFilter = 0;

  @override
  void initState() {
    super.initState();
    _shoppingItemsFuture = _loadItems(9);
  }

  Future<List<ShoppingItem>> _loadItems(int filter) async {
    //await DatabaseHelper.instance.resetDatabase(); //CAREFUL
    final items = await DatabaseHelper.instance.getItems();
    switch (filter) {
      case 2:
        //await Future.delayed(Duration(milliseconds: 100));
        _shoppingItems = items.where((item) => item.isBought).toList();
        return _shoppingItems;
      case 1:
        //await Future.delayed(Duration(milliseconds: 100));
        _shoppingItems = items.where((item) => !item.isBought).toList();
        return _shoppingItems;
      case 0:
        //await Future.delayed(Duration(milliseconds: 100));
        _shoppingItems = items;
        return _shoppingItems;
      default:
        _shoppingItems = items;
        return _shoppingItems;
    }
  }

  Future<void> _addItem(String name, int quantity) async {
    int id = await DatabaseHelper.instance.addItem(name, quantity);
    setState(() {
      _shoppingItems.add(ShoppingItem(id: id, name: name, quantity: quantity));
    });
  }

  Future<void> _editItem(int index, ShoppingItem updatedItem) async {
    setState(() {
      _shoppingItems[index] = updatedItem;
    });
    await DatabaseHelper.instance
        .editItem(updatedItem.id!, updatedItem.name, updatedItem.quantity);
  }

  void _removeItem(int index) {
    ShoppingItem item = _shoppingItems[index];
    setState(() {
      _shoppingItems.removeAt(index);
    });
    DatabaseHelper.instance.removeItem(item.id!);
  }

  void updateShoppingItems(List<ShoppingItem> items) {
    setState(() {
      _shoppingItems = items;
    });
  }

  void _showAddItemModalBottomSheet() {
    final itemNameController = TextEditingController();
    final itemQuantityController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
          child: Container(
            decoration: BoxDecoration(
              color: ColorOptions.colorscheme[700]!,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: ColorOptions.colorscheme[50]!),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                  ),
                  style: TextStyle(color: ColorOptions.colorscheme[50]!),
                ),
                TextField(
                  controller: itemQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: ColorOptions.colorscheme[50]),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ColorOptions.colorscheme[50]),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _addItem(
                      itemNameController.text,
                      int.parse(itemQuantityController.text),
                    );
                    Navigator.of(context).pop();
                    if (itemFilter == 2) {
                      // switch back to show all items
                      setState(() {
                        itemFilter = 0;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorOptions.colorscheme[50]!),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: ColorOptions.colorscheme[900]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditItemModalBottomSheet(ShoppingItem item, int index) {
    final newNameController = TextEditingController(text: item.name);
    final newQuantityController =
        TextEditingController(text: item.quantity.toString());

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
          child: Container(
            decoration: BoxDecoration(
              color: ColorOptions.colorscheme[700]!,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: ColorOptions.colorscheme[50]!),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                  ),
                  style: TextStyle(color: ColorOptions.colorscheme[50]!),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: newQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: ColorOptions.colorscheme[50]!),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorOptions.colorscheme[50]!),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: ColorOptions.colorscheme[50]!),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    ShoppingItem updatedItem = ShoppingItem(
                      name: newNameController.text,
                      quantity: int.parse(newQuantityController.text),
                    );
                    _editItem(index, updatedItem);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorOptions.colorscheme[50]!),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: ColorOptions.colorscheme[900]!),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Initialize the default selection values
  var selectedOptionIndex = 1; // Date Added is selected by default
  var selectedSortOrderIndex = 0; // Ascending is selected by default
  Future<List<ShoppingItem>> _showFilterBox() async {
    // Define the available options for filtering and sorting
    final options = ['Name', 'Date Added', 'Quantity'];

    List<ShoppingItem> _tempshoppingItems = [];

    // Show the filter dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filter Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show the available filtering options as radio buttons
                  for (int i = 0; i < options.length; i++)
                    ListTile(
                      title: Text(options[i]),
                      leading: Radio(
                        value: i,
                        groupValue: selectedOptionIndex,
                        onChanged: (value) {
                          setState(() {
                            selectedOptionIndex = value as int;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedOptionIndex = i;
                        });
                      },
                    ),
                  // Show the available sorting order options as radio buttons
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sort Order: '),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedSortOrderIndex =
                                selectedSortOrderIndex == 0 ? 1 : 0;
                          });
                        },
                        icon: selectedSortOrderIndex == 0
                            ? const Icon(Icons.arrow_upward)
                            : const Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('APPLY'),
                  onPressed: () {
                    setState(() {
                      // Sort the list based on the selected option and sorting order
                      switch (selectedOptionIndex) {
                        case 0: // Name
                          _tempshoppingItems = [..._shoppingItems]..sort(
                              (a, b) =>
                                  a.name.compareTo(b.name) *
                                  (selectedSortOrderIndex == 0 ? 1 : -1));
                          print('Sorted by Name');
                          break;
                        case 1: // Date Added
                          _tempshoppingItems = [..._shoppingItems]..sort(
                              (a, b) =>
                                  a.id!.compareTo(b.id!) *
                                  (selectedSortOrderIndex == 0 ? 1 : -1));
                          print('Sorted by Date Added');
                          break;
                        case 2: // Quantity
                          _tempshoppingItems = [..._shoppingItems]..sort(
                              (a, b) =>
                                  a.quantity.compareTo(b.quantity) *
                                  (selectedSortOrderIndex == 0 ? 1 : -1));
                          print('Sorted by Quantity');
                          break;
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
    return _tempshoppingItems;
  }

  Widget _buildItem(ShoppingItem item, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
      child: Card(
        color: !item.isBought
            ? ColorOptions.colorscheme[400]!
            : ColorOptions.colorscheme[100],
        elevation: 9,
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        child: Dismissible(
          key: Key(item.name),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _removeItem(index);
          },
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              leading: Transform.scale(
                scale: 1.27,
                child: ClipOval(
                  child: Checkbox(
                    value: item.isBought,
                    onChanged: (value) {
                      setState(() {
                        item.isBought = value!;
                        if (item.isBought) {
                          item.timeBought = DateTime.now().toString();
                          DatabaseHelper.instance.buyItem(item.id!);
                        } else {
                          item.timeBought = null;
                          DatabaseHelper.instance.unbuyItem(item.id!);
                        }
                        if (itemFilter != 0) {
                          //_shoppingItemsFuture = _loadItems(itemFilter);
                        }
                      });
                    },
                    activeColor: !item.isBought
                        ? ColorOptions.colorscheme[50]!
                        : ColorOptions.colorscheme[400]!,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
              title: Text(
                item.name,
                style: TextStyle(
                  color: item.isBought
                      ? ColorOptions.colorscheme[700]!
                      : ColorOptions.colorscheme[50]!,
                  decoration: item.isBought ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: item.isBought && item.timeBought != null
                  ? Text(
                      'Bought on ${DateFormat.yMd().format(DateTime.parse(item.timeBought!))}',
                      style: TextStyle(color: ColorOptions.colorscheme[300]),
                    )
                  : !item.isBought && item.timeBought == null
                      ? Text(
                          'Quantity: ${item.quantity}',
                          style:
                              TextStyle(color: ColorOptions.colorscheme[100]),
                        )
                      : null,
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                color: item.isBought
                    ? ColorOptions.colorscheme[400]
                    : ColorOptions.colorscheme[100],
                onPressed: () {
                  _showEditItemModalBottomSheet(item, index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: const [
              Text('Shopping List'),
            ],
          ),
          elevation: 8,
          shadowColor: ColorOptions.colorscheme[900]!,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(2),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 9.0),
              child: ToggleButtons(
                isSelected: [itemFilter == 0, itemFilter == 1, itemFilter == 2],
                onPressed: (int index) {
                  setState(() {
                    itemFilter = index;
                  });
                  _shoppingItemsFuture = _loadItems(itemFilter);
                },
                color: ColorOptions.colorscheme[50]?.withOpacity(0.60),
                selectedColor: ColorOptions.colorscheme[900],
                borderRadius: BorderRadius.circular(7.0),
                borderColor: ColorOptions.colorscheme[300]?.withOpacity(0.60),
                splashColor: ColorOptions.colorscheme[200]?.withOpacity(0.22),
                fillColor: ColorOptions.colorscheme[100]?.withOpacity(0.8),
                constraints: const BoxConstraints(
                  minWidth: 50.0,
                  minHeight: 45.0,
                  maxWidth: 50.0,
                  maxHeight: 45.0,
                ),
                children: const [
                  Icon(Icons.list),
                  Icon(Icons.shopping_cart),
                  Icon(Icons.done),
                ],
              ),
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _shoppingItemsFuture = _loadItems(itemFilter);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FutureBuilder<List<ShoppingItem>>(
            future: _shoppingItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Image.asset(
                    'assets/img/icon.png',
                    width: 200,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('An error has occurred, ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                if (itemFilter != 2) {
                  return const Center(
                    child: Text('No shopping items found'),
                  );
                } else {
                  return const Center(
                    child: Text('No items bought'),
                  );
                }
              }
              return ListView.builder(
                itemCount: _shoppingItems.length,
                itemBuilder: (context, index) {
                  final item = _shoppingItems[index];
                  return _buildItem(item, index);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'filter',
              onPressed: () async {
                final result = await _showFilterBox();
                if (result.isNotEmpty) {
                  updateShoppingItems(result);
                }
              },
              backgroundColor: ColorOptions.colorscheme[500]!,
              elevation: 10,
              child: const Icon(Icons.filter_list),
            ),
            FloatingActionButton(
              heroTag: 'additem',
              onPressed: _showAddItemModalBottomSheet,
              backgroundColor: ColorOptions.colorscheme[500]!,
              elevation: 10,
              child: const Icon(Icons.add_shopping_cart_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
