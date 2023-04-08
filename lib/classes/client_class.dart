//Class Client

class Client {
  String name;
  String email;
  String password;
  String cellphone;
  String birthday;
  String address;
  String genre;
  String city;
  int age;

  Client({
    required this.name,
    required this.email,
    required this.password,
    required this.cellphone,
    required this.birthday,
    required this.address,
    required this.genre,
    required this.city,
    required this.age,
  });
  factory Client.fromMap(Map<String, dynamic> json) => Client(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        cellphone: json["cellphone"],
        birthday: json["birthday"],
        address: json["address"],
        genre: json["genre"],
        city: json["city"],
        age: json["age"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "cellphone": cellphone,
        "birthday": birthday,
        "address": address,
        "genre": genre,
        "city": city,
        "age": age,
      };
}
