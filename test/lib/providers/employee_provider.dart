import 'package:flutter/material.dart';
import 'package:test/api/http_services.dart';

class EmployeesProvider extends ChangeNotifier {
  List _employees = [];
  List _searchQuery = [];
  String _searchName = 'all';
  int _searchRate = 0;

  EmployeesProvider() {
    getEmployeesFromDatabase();
  }

  Future<void> getEmployeesFromDatabase() async {
    List value = await HttpServices().getAllEmployees();
    _employees = value;
    notifyListeners();
  }

  List get employees => _employees;
  List get searchQuery => _searchQuery;

  set searchName(String name) {
    _searchName = name;
    notifyListeners();
  }

  String get searchName => _searchName;

  set searchRate(int rate) {
    _searchRate = rate;
    notifyListeners();
  }

  int get searchRate => _searchRate;

  void add(int id, String name, int hourlyRate) {
    _employees.add(
        {"id": id, "name": name, "hourly_rate": hourlyRate, "date": null, "time_in": null, "time_out": null});
    notifyListeners();
  }

  // Update the map with a specific ID
  void update(int id, Map<String, dynamic> updatedValues) {
    int index = _employees.indexWhere((map) => map['id'] == id);
    _employees[index].addAll(updatedValues);
    notifyListeners();
  }

  // Delete the map with a specific ID
  void delete(int id) {
    _employees.removeWhere((map) => map['id'] == id);
    notifyListeners();
  }

  // Search by both name and hourly_rate
  void searchByNameAndRate() {
    _searchQuery = _employees.where((map) {
      return map['name'] == _searchName || map['hourly_rate'] == _searchRate;
    }).toList();
    notifyListeners();
  }
}
