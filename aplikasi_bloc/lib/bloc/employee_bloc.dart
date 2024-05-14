import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class EmployeeBloc extends Cubit<List<Employee>> {
  EmployeeBloc() : super([]);

  Future<void> fetchEmployees() async {
    final response = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<Employee> employees = data.map((e) => Employee.fromJson(e)).toList();
      emit(employees);
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
