

class Service {
  int? id;
  int? clientId;
  int? carId;
  int? requestId;
  String name;
  String description;
  double serviceCost;
  int estimatedTime;
  Service({
    this.id,
    this.clientId,
    this.carId,
    this.requestId,
    required this.name,
    required this.description,
    required this.serviceCost,
    required this.estimatedTime,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        id: json["id"],
        clientId: json["clientId"],
        carId: json["carId"],
        requestId: json["requestId"],
        name: json["name"],
        description: json["description"],
        serviceCost: json["serviceCost"],
        estimatedTime: json["estimatedTime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "clientId": clientId,
        "carId": carId,
        "requestId": requestId,
        "name": name,
        "description": description,
        "serviceCost": serviceCost,
        "estimatedTime": estimatedTime,
      };
}
