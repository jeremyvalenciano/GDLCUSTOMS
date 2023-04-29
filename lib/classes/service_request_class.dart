class ServiceRequest {
  final int? id;
  final int? clientId;
  final int? carId;
  final int? employeeId;
  final String clientName;
  final String modelCar;
  final String brandCar;
  final String licencePlate;
  final String date;
  final String status;
  final String paid;
  ServiceRequest({
    this.id,
    this.clientId,
    this.carId,
    this.employeeId,
    required this.date,
    required this.clientName,
    required this.modelCar,
    required this.brandCar,
    required this.licencePlate,
    required this.status,
    required this.paid,
  });
  factory ServiceRequest.fromMap(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"],
        clientId: json["clientId"],
        carId: json["carId"],
        employeeId: json["employeeId"],
        clientName: json["clientName"],
        modelCar: json["modelCar"],
        brandCar: json["brandCar"],
        licencePlate: json["licencePlate"],
        date: json["date"],
        status: json["status"],
        paid: json["paid"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "clientId": clientId,
        "carId": carId,
        "employeeId": employeeId,
        "clientName": clientName,
        "modelCar": modelCar,
        "brandCar": brandCar,
        "licencePlate": licencePlate,
        "date": date,
        "status": status,
        "paid": paid,
      };
}
