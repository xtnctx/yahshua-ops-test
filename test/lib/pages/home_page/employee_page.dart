import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/api/http_services.dart';
import 'package:test/providers/employee_provider.dart';

class EmployeePage extends StatefulWidget {
  final int id;
  final String name;
  final int hourlyRate;
  final String date;
  final String timeIn;
  final String timeOut;

  const EmployeePage(
      {super.key,
      required this.id,
      required this.name,
      required this.hourlyRate,
      required this.date,
      required this.timeIn,
      required this.timeOut});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final nameController = TextEditingController();
  final hourlyRateController = TextEditingController();
  final dateController = TextEditingController();
  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();

  HttpServices httpService = HttpServices();
  Future? _futureUpdate;
  Future? _futureDelete;

  String? name;
  int? hourlyRate;
  String? date;
  String? timeIn;
  String? timeOut;

  @override
  void initState() {
    nameController.text = widget.name;
    hourlyRateController.text = widget.hourlyRate.toString();
    dateController.text = widget.date;
    timeInController.text = widget.timeIn;
    timeOutController.text = widget.timeOut;
    super.initState();
  }

  Map x = {
    "employee_id": 3,
    "name": "HELLO",
    "hourly_rate": 78999,
    "date": "1233",
    "time_in": "4566",
    "time_out": "1599"
  };

  void updatePage(EmployeesProvider employeeProvider, int id, Map<String, dynamic> data) {
    employeeProvider.update(id, data);
  }

  void deleteEmployee(EmployeesProvider employeeProvider, int id) {
    employeeProvider.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Consumer<EmployeesProvider>(
                builder: (BuildContext context, EmployeesProvider employeeProvider, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'id: ${widget.id.toString()}',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),

                  // Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: nameController,
                        autocorrect: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.name,
                          contentPadding: const EdgeInsets.only(left: 20.0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Hourly Rate
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: hourlyRateController,
                        autocorrect: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.hourlyRate.toString(),
                          contentPadding: const EdgeInsets.only(left: 20.0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: dateController,
                        autocorrect: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.date,
                          contentPadding: const EdgeInsets.only(left: 20.0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Time In
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: timeInController,
                        autocorrect: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.timeIn,
                          contentPadding: const EdgeInsets.only(left: 20.0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Time Out
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: timeOutController,
                        autocorrect: false,
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: widget.timeOut,
                          contentPadding: const EdgeInsets.only(left: 20.0),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Edit database
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(186, 76, 175, 79)),
                    onPressed: () {
                      setState(() {
                        print(widget.name);
                        print(widget.hourlyRate);
                        print(widget.date);
                        print(widget.timeIn);
                        print(widget.timeOut);
                        _futureUpdate = httpService.update(
                          id: widget.id,
                          name: nameController.text.isNotEmpty ? nameController.text : widget.name,
                          hourlyRate: hourlyRateController.text.isNotEmpty
                              ? int.parse(hourlyRateController.text)
                              : widget.hourlyRate,
                          date: dateController.text.isNotEmpty ? dateController.text : widget.date,
                          timeIn: timeInController.text.isNotEmpty ? timeInController.text : widget.timeIn,
                          timeOut:
                              timeOutController.text.isNotEmpty ? timeOutController.text : widget.timeOut,
                        );

                        name = nameController.text;
                        hourlyRate = int.parse(hourlyRateController.text);
                        date = dateController.text;
                        timeIn = timeInController.text;
                        timeOut = timeOutController.text;
                      });

                      _futureUpdate?.then((value) {
                        updatePage(employeeProvider, widget.id, {
                          'name': name,
                          'hourly_rate': hourlyRate,
                          'date': date,
                          'time_in': timeIn,
                          'time_out': timeOut,
                        });
                        Navigator.pop(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Delete employee
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(186, 244, 67, 54)),
                    onPressed: () {
                      setState(() {
                        _futureDelete = httpService.delete(id: widget.id);
                      });

                      _futureDelete?.then((value) {
                        deleteEmployee(employeeProvider, widget.id);
                        Navigator.pop(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: const Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
