class Car {
  int? id;
  int? clientId;
  String licencePlate;
  String model;
  String brand;
  String type;
  String carYear;
  String color;
  int kilometers;
  String lastService;
  int doors;
  Car({
    this.id,
    this.clientId,
    required this.licencePlate,
    required this.model,
    required this.brand,
    required this.type,
    required this.carYear,
    required this.color,
    required this.kilometers,
    required this.lastService,
    required this.doors,
  });

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        id: json["id"],
        clientId: json["clientId"],
        licencePlate: json["licencePlate"],
        model: json["model"],
        brand: json["brand"],
        type: json["type"],
        carYear: json["carYear"],
        color: json["color"],
        kilometers: json["kilometers"],
        lastService: json["lastService"],
        doors: json["doors"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "clientId": clientId,
        "licencePlate": licencePlate,
        "model": model,
        "brand": brand,
        "type": type,
        "carYear": carYear,
        "color": color,
        "kilometers": kilometers,
        "lastService": lastService,
        "doors": doors,
      };
}
