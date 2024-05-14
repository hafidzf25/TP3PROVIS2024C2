import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_bloc.dart';
import '../models/employee.dart';

class EmployeeListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: BlocProvider(
        create: (context) => EmployeeBloc()..fetchEmployees(),
        child: BlocBuilder<EmployeeBloc, List<Employee>>(
          builder: (context, employees) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Salary')),
                  DataColumn(label: Text('Age')),
                ],
                rows: employees
                    .map(
                      (employee) => DataRow(
                        cells: [
                          DataCell(Text(employee.id.toString())),
                          DataCell(Text(employee.employeeName)),
                          DataCell(Text(employee.employeeSalary.toString())),
                          DataCell(Text(employee.employeeAge.toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}