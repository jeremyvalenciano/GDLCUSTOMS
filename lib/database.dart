// This file contains the database helper class
import 'dart:io';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/classes/admin_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/classes/service_class.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'gdlcustom.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE AdministratorGDL (
            email TEXT PRIMARY KEY,
            password TEXT NOT NULL,
            name TEXT NOT NULL,
            cellphone TEXT NOT NULL
          )
          ''');
    await db.execute('''
          INSERT INTO AdministratorGDL (email, password, name, cellphone) VALUES ('admin@gmail.com','123456','Admin','1234567890')
          ''');
    await db.execute('''
          PRAGMA foreign_keys = ON;
          ''');
    await db.execute('''
          CREATE TABLE Clients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            cellphone TEXT NOT NULL UNIQUE,
            birthday TEXT NOT NULL,
            address TEXT NOT NULL,
            genre TEXT NOT NULL,
            city TEXT NOT NULL,
            age INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE Employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rfc TEXT UNIQUE,
            name TEXT NOT NULL,
            password TEXT NOT NULL,
            cellphone TEXT NOT NULL,
            email TEXT NOT NULL,
            address TEXT NOT NULL,
            city TEXT NOT NULL,
            genre TEXT NOT NULL,
            birthday TEXT NOT NULL,
            age INTEGER NOT NULL,
            role TEXT NOT NULL,
            fiscalRegime TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE Cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER NOT NULL,
            licencePlate TEXT NOT NULL UNIQUE,
            model TEXT NOT NULL,
            brand TEXT NOT NULL,
            type TEXT NOT NULL,
            carYear TEXT NOT NULL,
            color TEXT NOT NULL,
            kilometers INTEGER NOT NULL ,
            lastService TEXT NOT NULL,
            kmNextService INTEGER DEFAULT 0,
            doors INTEGER NOT NULL,
            FOREIGN KEY (clientId) REFERENCES Clients(id)
          )
          ''');
    await db.execute('''
          CREATE TABLE Services (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER NOT NULL,
            carId INTEGER NOT NULL,
            name TEXT NOT NULL,
            description TEXT NOT NULL UNIQUE,
            productsCost FLOAT DEFAULT 0,
            serviceCost FLOAT DEFAULT 0,
            finalCost FLOAT DEFAULT 0,
            FOREIGN KEY (clientId) REFERENCES Clients(id),
            FOREIGN KEY (carId) REFERENCES Cars(id)
          )
          ''');
  }

  //General functions
  Future<bool> loginAdmin(String email, String password) async {
    // Get a reference to the database
    Database db = await instance.database;

    // Query the database for an admin user with the given email and password
    final List<Map<String, dynamic>> result = await db.query(
      'AdministratorGDL',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    // If we found a matching admin user, return true; otherwise, return false
    return result.isNotEmpty;
  }
  //Admin Functions

  Future<List<Admin>> getAdmins() async {
    Database db = await instance.database;
    var result = await db.query('AdministratorGDL');
    List<Admin> admins = result.isNotEmpty
        ? result.map((json) => Admin.fromMap(json)).toList()
        : [];
    return admins;
  }

  Future<Admin> getAdminByEmail(String email) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      '',
      where: 'email= ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Admin(
        email: maps.first['email'],
        password: maps.first['password'],
        name: maps.first['name'],
        cellphone: maps.first['cellphone'],
      );
    } else {
      throw Exception('No se encontró el empleado con el email: $email');
    }
  }

  Future<int> insertAdmin(Admin admin) async {
    Database db = await instance.database;
    return await db.insert('AdministratorGDL', admin.toMap());
  }

  Future<int> deleteAdmin(String email) async {
    Database db = await instance.database;
    return await db
        .delete('AdministratorGDL', where: 'email = ?', whereArgs: [email]);
  }

  //Client Functions
  Future<List<Client>> getClients() async {
    Database db = await instance.database;
    var result = await db.query('Clients');
    List<Client> clients = result.isNotEmpty
        ? result.map((json) => Client.fromMap(json)).toList()
        : [];
    return clients;
  }

  Future<int> insertClient(Client client) async {
    Database db = await instance.database;
    return await db.insert('Clients', client.toMap());
  }

  Future<int> deleteClient(String email) async {
    Database db = await instance.database;
    return await db.delete('Clients', where: 'email = ?', whereArgs: [email]);
  }

  Future<Client> getClientByEmail(String email) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Clients',
      where: 'email= ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Client(
        id: maps.first['id'],
        email: maps.first['email'],
        password: maps.first['password'],
        name: maps.first['name'],
        cellphone: maps.first['cellphone'],
        birthday: maps.first['birthday'],
        address: maps.first['address'],
        genre: maps.first['genre'],
        city: maps.first['city'],
        age: maps.first['age'],
      );
    } else {
      throw Exception('No se encontró el cliente con el email: $email');
    }
  }

  Future<bool> loginClient(String email, String password) async {
    // Get a reference to the database
    Database db = await instance.database;

    // Query the database for an admin user with the given email and password
    final List<Map<String, dynamic>> result = await db.query(
      'CLients',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    // If we found a matching admin user, return true; otherwise, return false
    return result.isNotEmpty;
  }

  //Employee Functions
  Future<List<Employee>> getEmployees() async {
    Database db = await instance.database;
    var result = await db.query('Employees');
    List<Employee> employees = result.isNotEmpty
        ? result.map((json) => Employee.fromMap(json)).toList()
        : [];
    return employees;
  }

  Future<Employee> getEmployeeById(String rfc) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Employees',
      where: 'rfc= ?',
      whereArgs: [rfc],
    );
    if (maps.isNotEmpty) {
      return Employee(
        rfc: maps.first['rfc'],
        password: maps.first['password'],
        name: maps.first['name'],
        cellphone: maps.first['cellphone'],
        email: maps.first['email'],
        address: maps.first['address'],
        city: maps.first['city'],
        genre: maps.first['genre'],
        birthday: maps.first['birthday'],
        age: maps.first['age'],
        role: maps.first['role'],
        fiscalRegime: maps.first['fiscalRegime'],
      );
    } else {
      throw Exception('No se encontró el empleado con el RFC: $rfc');
    }
  }

  Future<int> insertEmployee(Employee employee) async {
    Database db = await instance.database;
    return await db.insert('Employees', employee.toMap());
  }

  Future<int> deleteEmployee(String rfc) async {
    Database db = await instance.database;
    return await db.delete('Employees', where: 'rfc = ?', whereArgs: [rfc]);
  }

  //Service Functions
  Future<List<Service>> getServices() async {
    Database db = await instance.database;
    var result = await db.query('Services');
    List<Service> services = result.isNotEmpty
        ? result.map((json) => Service.fromMap(json)).toList()
        : [];
    return services;
  }

  Future<int> insertService(Service service) async {
    Database db = await instance.database;
    return await db.insert('Services', service.toMap());
  }

  Future<int> deleteService(int id) async {
    Database db = await instance.database;
    return await db.delete('Services', where: 'id = ?', whereArgs: [id]);
  }

  //Car Functions
  Future<List<Car>> getCars() async {
    Database db = await instance.database;
    var result = await db.query('Cars');
    List<Car> cars = result.isNotEmpty
        ? result.map((json) => Car.fromMap(json)).toList()
        : [];
    return cars;
  }

  Future<int> insertCar(Car car) async {
    Database db = await instance.database;
    return await db.insert('Cars', car.toMap());
  }

  Future<int> deleteCar(int? id) async {
    Database db = await instance.database;
    return await db.delete('Cars', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Car>> getCarsByClientId(int? id) async {
    Database db = await instance.database;
    var result = await db.query(
      'Cars',
      where: 'clientId = ?',
      whereArgs: [id],
    );
    List<Car> cars = result.isNotEmpty
        ? result.map((json) => Car.fromMap(json)).toList()
        : [];
    return cars;
  }
}
