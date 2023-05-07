class Ticket {
  final int? id;
  final int? carId;
  final int? clientId;
  final int? requestId;
  final int? employeeId;
  final double total;
  final String date;
  final double? iva;
  Ticket({
    this.id,
    this.carId,
    this.clientId,
    this.requestId,
    this.employeeId,
    required this.total,
    required this.date,
    this.iva,
  });
  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        carId: json["carId"],
        clientId: json["clientId"],
        requestId: json["requestId"],
        employeeId: json["employeeId"],
        total: json["total"],
        date: json["date"],
        iva: json["iva"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "carId": carId,
        "clientId": clientId,
        "requestId": requestId,
        "employeeId": employeeId,
        "total": total,
        "date": date,
        "iva": iva,
      };
}
