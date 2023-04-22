class Car {
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
