import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/api/env.dart';
import 'package:test/api/models.dart';

class HttpServices {
  // POST
  Future<Login> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse("${Env.DEV_URI}/api/api-auth/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': email,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return Login.fromJson(jsonDecode(response.body));
    } else {
      throw Login.onError(jsonDecode(response.body));
    }
  }

  //GET
  Future getAllEmployees() async {
    final response = await http.get(
      Uri.parse("${Env.BASE_URL}/employees/all/"),
    );
    final employees = json.decode(response.body);

    return employees;
  }

  //PUT
  Future update({
    required int id,
    required String name,
    required int hourlyRate,
    required String? date,
    required String? timeIn,
    required String? timeOut,
  }) async {
    final response = await http.put(
      Uri.parse("${Env.BASE_URL}/employees/create/"),
      headers: <String, String>{
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'employee_id': id,
          'name': name,
          'hourly_rate': hourlyRate,
          'date': date,
          'time_in': timeIn,
          'time_out': timeOut,
        },
      ),
    );
    final employees = json.decode(response.body);

    return employees;
  }

  //DELETE
  Future delete({required int id}) async {
    final response = await http.delete(
      Uri.parse("${Env.BASE_URL}/employees/$id/"),
    );
    final employees = json.decode(response.body);

    return employees;
  }

  // CREATE
  Future create({required String name, required int hourlyRate}) async {
    final response = await http.post(
      Uri.parse("${Env.BASE_URL}/employees/create/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': name,
          'hourly_rate': hourlyRate,
        },
      ),
    );
    final employees = json.decode(response.body);

    return employees;
  }
}
