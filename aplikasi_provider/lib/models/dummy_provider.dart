import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Employee.dart';

class HttpProvider with ChangeNotifier {
  List<dynamic> _employees = [];
  
  List<dynamic> get employees => _employees;

  late Uri url;

  void connectAPI(BuildContext context) async {

    final hasilResponse = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));

    if (hasilResponse.statusCode == 200) {
      print("Berhasil mengambil data");
      _employees = (json.decode(hasilResponse.body))["data"];
      notifyListeners();
      // print(_employees);
      handlingStatusCode(context, "BERHASIL GET DATA");
    } else {
      // gagal mengambil data dari server
      print("Gagal mengambil data");
      connectAPI(context);
      handlingStatusCode(context, "ERROR ${hasilResponse.statusCode}");
    }
  }

  // void deleteData(BuildContext context) async {
  //   var hasilResponse = await http.delete(url);

  //   print(hasilResponse.statusCode);

  //   if (hasilResponse.statusCode == 204) {
  //     _data = {};
  //     notifyListeners();
  //     handlingStatusCode(context, "No content !");
  //   }
  // }

  handlingStatusCode(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 700),
      ),
    );
  }
}