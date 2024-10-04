// ignore_for_file: non_constant_identifier_names

// POST
class Login {
  final String token;
  final String user_logged;
  final String company_name;
  final int company_id;
  final int emp_id_digits;
  final int employee_id;
  final String rate_settings;
  final List holidays;
  final List workdays;

  final Map<String, dynamic>? errorMsg;

  Login({
    required this.user_logged,
    required this.token,
    required this.company_name,
    required this.company_id,
    required this.emp_id_digits,
    required this.employee_id,
    required this.rate_settings,
    required this.holidays,
    required this.workdays,
    this.errorMsg,
  });

  factory Login.fromJson(Map<String, dynamic> data) => Login(
        token: data['token'],
        user_logged: data['user_logged'],
        company_name: data['company_name'],
        company_id: data['company_id'],
        emp_id_digits: data['emp_id_digits'],
        employee_id: data['employee_id'],
        rate_settings: data['rate_settings'],
        holidays: data['holidays'],
        workdays: data['workdays'],
      );

  factory Login.onError(Map<String, dynamic>? data) => Login(
        token: '',
        user_logged: '',
        company_name: '',
        company_id: 0,
        emp_id_digits: 0,
        employee_id: 0,
        rate_settings: '',
        holidays: [],
        workdays: [],
        errorMsg: data,
      );

  Map<String, dynamic> get toJson => {
        "token": token,
        "user_logged": user_logged,
        "company_name": company_name,
        "company_id": company_id,
        "emp_id_digits": emp_id_digits,
        "employee_id": employee_id,
        "rate_settings": rate_settings,
        "holidays": holidays,
        "workdays": workdays,
      };
}

class Employee {
  final int id;
  final String name;
  final int hourly_rate;
  final String date;
  final String time_in;
  final String time_out;

  Employee(
      {required this.id,
      required this.name,
      required this.hourly_rate,
      required this.date,
      required this.time_in,
      required this.time_out});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      hourly_rate: json['hourly_rate'],
      date: json['date'],
      time_in: json['time_in'],
      time_out: json['time_out'],
    );
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
        'hourly_rate': hourly_rate,
        'date': date,
        'time_in': time_in,
        'time_out': time_out,
      };
}

// Dont have much time...
