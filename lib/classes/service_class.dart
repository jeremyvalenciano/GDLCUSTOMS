import 'dart:ffi';

class Service {
  int clientId;
  int carId;
  String name;
  String description;
  Double productsCost;
  Double serviceCost;
  Double finalCost;
  Service({
    required this.clientId,
    required this.carId,
    required this.name,
    required this.description,
    required this.productsCost,
    required this.serviceCost,
    required this.finalCost,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        clientId: json["clientId"],
        carId: json["carId"],
        name: json["name"],
        description: json["description"],
        productsCost: json["productsCost"],
        serviceCost: json["serviceCost"],
        finalCost: json["finalCost"],
      );

  Map<String, dynamic> toMap() => {
        "clientId": clientId,
        "carId": carId,
        "name": name,
        "description": description,
        "productsCost": productsCost,
        "serviceCost": serviceCost,
        "finalCost": finalCost,
      };
}
