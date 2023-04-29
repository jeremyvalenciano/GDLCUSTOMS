

class Service {
  int? clientId;
  int? carId;
  int? requestId;
  String name;
  String description;
  double? productsCost;
  double serviceCost;
  double? finalCost;
  int estimatedTime;
  Service({
    this.clientId,
    this.carId,
    this.requestId,
    required this.name,
    required this.description,
    this.productsCost,
    required this.serviceCost,
    this.finalCost,
    required this.estimatedTime,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        clientId: json["clientId"],
        carId: json["carId"],
        requestId: json["requestId"],
        name: json["name"],
        description: json["description"],
        productsCost: json["productsCost"],
        serviceCost: json["serviceCost"],
        finalCost: json["finalCost"],
        estimatedTime: json["estimatedTime"],
      );

  Map<String, dynamic> toMap() => {
        "clientId": clientId,
        "carId": carId,
        "requestId": requestId,
        "name": name,
        "description": description,
        "productsCost": productsCost,
        "serviceCost": serviceCost,
        "finalCost": finalCost,
        "estimatedTime": estimatedTime,
      };
}
