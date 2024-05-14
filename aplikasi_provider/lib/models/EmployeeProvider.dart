import '../main.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeeProvider with ChangeNotifier {
  List<Employee> _employees = [];
  bool _isLoading = false;

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;

  Future<void> fetchEmployees() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse("https://dummy.restapiexample.com/api/v1/employees"));

    if (response.statusCode == 200) {
      final List<dynamic> employeeJson = json.decode(response.body)['data'];
      _employees = employeeJson.map((json) => Employee.fromJson(json)).toList();
    } else {
      fetchEmployees();
      throw Exception('Gagal untuk load data, error ${response.statusCode}');
    }

    _isLoading = false;
    notifyListeners();
  }
}