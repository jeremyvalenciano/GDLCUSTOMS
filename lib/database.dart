// This file contains the database helper class
import 'dart:io';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/classes/admin_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/classes/service_class.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/service_request_class.dart';
import 'package:proyectobd/classes/ticket_class.dart';
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
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            cellphone TEXT NOT NULL UNIQUE,
            birthday TEXT NOT NULL,
            address TEXT NOT NULL,
            genre TEXT NOT NULL,
            city TEXT NOT NULL,
            age INTEGER DEFAULT 0
          )
          ''');
    await db.execute('''
          CREATE TABLE Employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            rfc TEXT UNIQUE,
            name TEXT NOT NULL,
            password TEXT NOT NULL,
            cellphone TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            address TEXT NOT NULL,
            city TEXT NOT NULL,
            genre TEXT NOT NULL,
            birthday TEXT NOT NULL,
            age INTEGER DEFAULT 0,
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
          CREATE TABLE Requests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER NOT NULL,
            carId INTEGER NOT NULL,
            employeeId INTEGER DEFAULT 0,
            clientName TEXT NOT NULL,
            employeeName TEXT DEFAULT 'N/A',
            modelCar TEXT NOT NULL,
            brandCar TEXT NOT NULL,
            licencePlate TEXT NOT NULL,
            date TEXT NOT NULL,
            status TEXT DEFAULT 'Revision',
            paid TEXT DEFAULT 'No',
            FOREIGN KEY (clientId) REFERENCES Clients(id),
            FOREIGN KEY (employeeId) REFERENCES Employees(id),
            FOREIGN KEY (carId) REFERENCES Cars(id)
          )
          ''');
    await db.execute('''
          CREATE TABLE Services (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            clientId INTEGER NOT NULL,
            carId INTEGER NOT NULL,
            requestId INTEGER NOT NULL,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            productsCost FLOAT DEFAULT 0,
            serviceCost FLOAT DEFAULT 0,
            finalCost FLOAT DEFAULT 0,
            estimatedTime INT DEFAULT 0,
            FOREIGN KEY (clientId) REFERENCES Clients(id),
            FOREIGN KEY (carId) REFERENCES Cars(id),
            FOREIGN KEY (requestId) REFERENCES Requests(id)
          )
          ''');
    await db.execute('''
          CREATE TABLE Tickets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId INTEGER NOT NULL,
            clientId INTEGER NOT NULL,
            requestId INTEGER NOT NULL,
            employeeId INTEGER NOT NULL,
            total FLOAT DEFAULT 0,
            date TEXT NOT NULL,
            IVA INTEGER DEFAULT 0,
            FOREIGN KEY (carId) REFERENCES Cars(id),
            FOREIGN KEY (clientId) REFERENCES Clients(id),
            FOREIGN KEY (requestId) REFERENCES Requests(id),
            FOREIGN KEY (employeeId) REFERENCES Employees(id)
          )
          ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS check_unique_email_client
      BEFORE INSERT ON Clients
      FOR EACH ROW
      BEGIN
        SELECT CASE WHEN (SELECT 1 FROM Clients WHERE email = NEW.email) THEN
          RAISE(ABORT, 'Error: Client email already exists')
        END;
      END;
    ''');
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS check_unique_email_employee
      BEFORE INSERT ON Employees
      FOR EACH ROW
      BEGIN
        SELECT CASE WHEN (SELECT 1 FROM Employees WHERE email = NEW.email) THEN
          RAISE(ABORT, 'Error: Employee email already exists')
        END;
      END;
    ''');
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS check_unique_licence_plate
      BEFORE INSERT ON Cars
      FOR EACH ROW
      BEGIN
        SELECT CASE WHEN (SELECT 1 FROM Cars WHERE licencePlate = NEW.licencePlate) THEN
          RAISE(ABORT, 'Error: LicencePlate already exists')
        END;
      END;
    ''');
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS check_unique_rfc
      BEFORE INSERT ON Employees
      FOR EACH ROW
      BEGIN
        SELECT CASE WHEN (SELECT 1 FROM Employees WHERE rfc = NEW.rfc) THEN
          RAISE(ABORT, 'Error: rfc already exists')
        END;
      END;
    ''');
  }

  //Trigger functions

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
      'AdministratorGDL',
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
    final db = await instance.database;
    return await db.insert(
      'Clients',
      client.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<Client> getClientById(int id) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Clients',
      where: 'id= ?',
      whereArgs: [id],
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
      throw Exception('No se encontró el cliente con el id: $id');
    }
  }

  Future<bool> loginClient(String email, String password) async {
    // Get a reference to the database
    Database db = await instance.database;

    // Query the database for an admin user with the given email and password
    final List<Map<String, dynamic>> result = await db.query(
      'Clients',
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

  Future<int> insertEmployee(Employee employee) async {
    Database db = await instance.database;
    return await db.insert('Employees', employee.toMap());
  }

  Future<int> deleteEmployee(String rfc) async {
    Database db = await instance.database;
    return await db.delete('Employees', where: 'rfc = ?', whereArgs: [rfc]);
  }

  Future<bool> loginEmployee(String email, String password) async {
    // Get a reference to the database
    Database db = await instance.database;

    // Query the database for an admin user with the given email and password
    final List<Map<String, dynamic>> result = await db.query(
      'Employees',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    // If we found a matching admin user, return true; otherwise, return false
    return result.isNotEmpty;
  }

  Future<Employee> getEmployeeById(int id) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Employees',
      where: 'id= ?',
      whereArgs: [id],
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
      throw Exception('No se encontró el empleado con el : $id');
    }
  }

  Future<Employee> getEmployeeByEmail(String email) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Employees',
      where: 'email= ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Employee(
        id: maps.first['id'],
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
      throw Exception('No se encontró el empleado con el email: $email');
    }
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

  Future<List<Service>> getServicesByRequestId(int requestId) async {
    Database db = await instance.database;
    var result = await db
        .query('Services', where: 'requestId = ?', whereArgs: [requestId]);
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

  Future<Car> getCarByLicencePlate(String licencePlate) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Cars',
      where: 'licencePlate= ?',
      whereArgs: [licencePlate],
    );
    if (maps.isNotEmpty) {
      return Car(
        id: maps.first['id'],
        clientId: maps.first['clientId'],
        licencePlate: maps.first['licencePlate'],
        brand: maps.first['brand'],
        type: maps.first['type'],
        model: maps.first['model'],
        carYear: maps.first['year'],
        color: maps.first['color'],
        kilometers: maps.first['kilometers'],
        lastService: maps.first['lastService'],
        doors: maps.first['doors'],
      );
    } else {
      throw Exception('No se encontró el auto por las placas: $licencePlate');
    }
  }

  Future<Car> getCarById(int id) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Cars',
      where: 'id= ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Car(
        id: maps.first['id'],
        clientId: maps.first['clientId'],
        licencePlate: maps.first['licencePlate'],
        brand: maps.first['brand'],
        type: maps.first['type'],
        model: maps.first['model'],
        carYear: maps.first['year'],
        color: maps.first['color'],
        kilometers: maps.first['kilometers'],
        lastService: maps.first['lastService'],
        doors: maps.first['doors'],
      );
    } else {
      throw Exception('No se encontró el carro con el id: $id');
    }
  }

  //Request Functions
  Future<int> insertRequest(ServiceRequest request) async {
    Database db = await instance.database;
    int id = await db.insert('Requests', request.toMap());
    return id;
  }

  Future<ServiceRequest> getRequestById(int? id) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Requests',
      where: 'id= ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ServiceRequest(
        id: maps.first["id"],
        clientId: maps.first["clientId"],
        carId: maps.first["carId"],
        employeeId: maps.first["employeeId"],
        clientName: maps.first["clientName"],
        employeeName: maps.first["employeeName"],
        modelCar: maps.first["modelCar"],
        brandCar: maps.first["brandCar"],
        licencePlate: maps.first["licencePlate"],
        date: maps.first["date"],
        status: maps.first["status"],
        paid: maps.first["paid"],
      );
    } else {
      throw Exception('No se encontró el carro con el id: $id');
    }
  }

  Future<List<ServiceRequest>> getRequests() async {
    Database db = await instance.database;
    var result = await db
        .query('Requests', where: 'status = ?', whereArgs: ['Pendiente']);
    List<ServiceRequest> requests = result.isNotEmpty
        ? result.map((json) => ServiceRequest.fromMap(json)).toList()
        : [];
    return requests;
  }

  Future<int> deleteRequest(int? id) async {
    Database db = await instance.database;
    return await db.delete('Requests', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> asignEmployeeIdToRequest(
      int id, int employeeId, String empName) async {
    Database db = await instance.database;
    await db.rawUpdate(
        'UPDATE Requests SET employeeId = ? WHERE id = ?', [employeeId, id]);
    await db.rawUpdate(
        'UPDATE Requests SET status = ? WHERE id = ?', ['Aceptado', id]);
    await db.rawUpdate(
        'UPDATE Requests SET employeeName = ? WHERE id = ?', [empName, id]);
  }

  Future<void> updateRequestStatus(int id, String status) async {
    Database db = await instance.database;
    await db
        .rawUpdate('UPDATE Requests SET status = ? WHERE id = ?', [status, id]);
  }

  Future<ServiceRequest> getRequestIdBylicence(String licencePlate) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Requests',
      where: 'licencePlate= ?',
      whereArgs: [licencePlate],
    );
    if (maps.isNotEmpty) {
      return ServiceRequest(
        id: maps.first["id"],
        clientId: maps.first["clientId"],
        carId: maps.first["carId"],
        clientName: maps.first["clientName"],
        employeeName: maps.first["employeeName"],
        modelCar: maps.first["modelCar"],
        brandCar: maps.first["brandCar"],
        licencePlate: maps.first["licencePlate"],
        date: maps.first["date"],
        status: maps.first["status"],
        paid: maps.first["paid"],
      );
    } else {
      throw Exception(
          'No se encontró la request con las placas: $licencePlate');
    }
  }

  Future<List<ServiceRequest>> getRequestsByEmployeeId(int employeeId) async {
    Database db = await instance.database;
    var result = await db.query('Requests',
        where:
            'employeeId = ? AND (status = "Aceptado" OR status = "En proceso")',
        whereArgs: [employeeId]);
    List<ServiceRequest> requests = result.isNotEmpty
        ? result.map((json) => ServiceRequest.fromMap(json)).toList()
        : [];
    return requests;
  }

  //Ticket Functions
  Future<List<Ticket>> getTickets() async {
    Database db = await instance.database;
    var result = await db.query('Tickets');
    List<Ticket> tickets = result.isNotEmpty
        ? result.map((json) => Ticket.fromMap(json)).toList()
        : [];
    return tickets;
  }

  Future<List<Ticket>> getTicketsByClientId(int id) async {
    Database db = await instance.database;
    var result =
        await db.query('Tickets', where: 'clientId = ?', whereArgs: [id]);
    List<Ticket> tickets = result.isNotEmpty
        ? result.map((json) => Ticket.fromMap(json)).toList()
        : [];
    return tickets;
  }

  Future<int> insertTicket(Ticket ticket) async {
    Database db = await instance.database;
    return await db.insert('Tickets', ticket.toMap());
  }
}
