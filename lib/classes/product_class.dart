import 'dart:ffi';

class Product {
  int productId;
  int serviceId;
  String name;
  String description;
  String branch;
  int quantity;
  Double price;

  Product({
    required this.productId,
    required this.serviceId,
    required this.name,
    required this.description,
    required this.branch,
    required this.quantity,
    required this.price,
  });
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        serviceId: json["serviceId"],
        name: json["name"],
        description: json["description"],
        branch: json["branch"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "serviceId": serviceId,
        "name": name,
        "description": description,
        "branch": branch,
        "quantity": quantity,
        "price": price,
      };
}
