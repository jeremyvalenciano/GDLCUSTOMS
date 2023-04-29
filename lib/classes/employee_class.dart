//Class Employee

class Employee {
  int? id;
  String rfc;
  String name;
  String email;
  String password;
  String cellphone;
  String birthday;
  String address;
  String genre;
  String city;
  int age;
  String role;
  String fiscalRegime;

  Employee({
    this.id,
    required this.rfc,
    required this.name,
    required this.email,
    required this.password,
    required this.cellphone,
    required this.birthday,
    required this.address,
    required this.genre,
    required this.city,
    required this.age,
    required this.role,
    required this.fiscalRegime,
  });
  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        rfc: json["rfc"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        cellphone: json["cellphone"],
        birthday: json["birthday"],
        address: json["address"],
        genre: json["genre"],
        city: json["city"],
        age: json["age"],
        role: json["role"],
        fiscalRegime: json["fiscalRegime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rfc": rfc,
        "name": name,
        "email": email,
        "password": password,
        "cellphone": cellphone,
        "birthday": birthday,
        "address": address,
        "genre": genre,
        "city": city,
        "age": age,
        "role": role,
        "fiscalRegime": fiscalRegime,
      };
}
