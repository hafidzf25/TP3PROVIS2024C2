import 'package:aplikasi_provider/models/EmployeeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }
}

// Model
class Employee {
  final int id;
  final String nama;
  final int gaji;
  final int umur;
  final String urlFoto;

  Employee({
    required this.id,
    required this.nama,
    required this.gaji,
    required this.umur,
    required this.urlFoto,
  });

  factory Employee.fromJson(Map<String, dynamic> data) {
    return Employee(
      id: data['id'],
      nama: data['employee_name'],
      gaji: data['employee_salary'],
      umur: data['employee_age'],
      urlFoto: data['profile_image'],
    );
  }
}

// UI
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Employees'),
        actions: [
          ElevatedButton(
            onPressed: () {
              employeeProvider.fetchEmployees();
            },
            child: Icon(Icons.refresh),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: Center(
        child: employeeProvider.isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: employeeProvider.employees.length,
                itemBuilder: (context, index) {
                  final employee = employeeProvider.employees[index];
                  return ListTile(
                    title: Text(employee.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gaji: \$${employee.gaji}'),
                        Text('Umur: ${employee.umur}'),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://picsum.photos/id/${employee.id + 1}/300/200"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
