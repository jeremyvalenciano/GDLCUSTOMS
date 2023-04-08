class Admin {
  final String email;
  final String password;
  final String name;
  final String cellphone;
  Admin(
      {required this.email,
      required this.password,
      required this.name,
      required this.cellphone});

  factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        cellphone: json["cellphone"],
      );
  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "name": name,
        "cellphone": cellphone,
      };
}
