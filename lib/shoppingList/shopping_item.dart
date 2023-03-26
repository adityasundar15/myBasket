class ShoppingItem {
  final int? id;
  String name;
  int quantity;
  bool isBought;
  String? timeBought;

  ShoppingItem({
    this.id,
    required this.name,
    required this.quantity,
    this.isBought = false,
    this.timeBought,
  });

  factory ShoppingItem.fromMap(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      isBought: json['isBought'] == 1,
      timeBought: json['timeBought'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'isBought': isBought == false ? 0 : 1,
      'timeBought': timeBought,
    };
  }
}
