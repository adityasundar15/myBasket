class ShoppingItem {
  final int? id;
  String name;
  int quantity;
  bool isBought;
  String? timeBought;
  String? fridgeExpiryDate;
  String? shelfExpiryDate;
  String? category;

  ShoppingItem({
    this.id,
    required this.name,
    required this.quantity,
    this.isBought = false,
    this.timeBought,
    this.fridgeExpiryDate,
    this.shelfExpiryDate,
    this.category,
  });

  factory ShoppingItem.fromMap(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      isBought: json['isBought'] == 1,
      timeBought: json['timeBought'],
      fridgeExpiryDate: json['fridgeExpiryDate'],
      shelfExpiryDate: json['shelfExpiryDate'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isBought': isBought == false ? 0 : 1,
      'timeBought': timeBought,
      'fridgeExpiryDate': fridgeExpiryDate,
      'shelfExpiryDate': shelfExpiryDate,
      'category': category,
    };
  }
}
