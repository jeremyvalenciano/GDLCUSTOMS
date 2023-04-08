// This file contains the database helper class
import 'dart:io';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'classes/admin_class.dart';
import 'classes/client_class.dart';

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
          CREATE TABLE Clients (
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            cellphone TEXT NOT NULL,
            birthday TEXT NOT NULL,
            address TEXT NOT NULL,
            genre TEXT NOT NULL,
            city TEXT NOT NULL,
            age INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE Employees (
            rfc TEXT PRIMARY KEY,
            password TEXT NOT NULL,
            name TEXT NOT NULL,
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
    /*var result = await db.query('Employees');
    List<Employee> employees = result.isNotEmpty
        ? result.map((json) => Employee.fromMap(json)).toList()
        : [];
    return employees;*/
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
}
