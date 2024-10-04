import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/api/http_services.dart';
import 'package:test/pages/home_page/employee_page.dart';
import 'package:test/pages/home_page/home_widgets/custom_searchbar.dart';
import 'package:test/providers/employee_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpServices httpServices = HttpServices();
  EmployeesProvider employeeProvider = EmployeesProvider();
  Future? _futureCreate;

  final nameController = TextEditingController();
  final hourlyRateController = TextEditingController();

  Widget employeeTile({
    required int id,
    required String name,
    required int hourlyRate,
    required String? date,
    required String? timeIn,
    required String? timeOut,
  }) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.person,
          size: 50.0,
        ),
        title: Text(name),
        subtitle: Text('id: $id, Hourly rate: $hourlyRate'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeePage(
                id: id,
                name: name,
                hourlyRate: hourlyRate,
                date: date ?? 'null',
                timeIn: timeIn ?? 'null',
                timeOut: timeOut ?? 'null',
              ),
            ),
          );
        },
      ),
    );
  }

  void addEmployee(EmployeesProvider employeeProvider, int id, String name, int hourlyRate) {
    employeeProvider.add(id, name, hourlyRate);
  }

  Future openCreationForm(EmployeesProvider employeeProvider) {
    return showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: nameController,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Name (len >= 4)',
                            contentPadding: EdgeInsets.only(left: 20.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextField(
                          controller: hourlyRateController,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Hourly Rate (len > 3)',
                            contentPadding: EdgeInsets.only(left: 20.0),
                          ),
                        ),
                      ),
                      Consumer<EmployeesProvider>(
                          builder: (BuildContext context, EmployeesProvider value, Widget? child) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            child: const Text('Add Employee'),
                            onPressed: () {
                              if (nameController.text.length < 4) return;

                              if (hourlyRateController.text.length < 3 && hourlyRateController.text is! int) {
                                return;
                              }
                              _futureCreate = httpServices.create(
                                name: nameController.text,
                                hourlyRate: int.parse(hourlyRateController.text),
                              );

                              _futureCreate?.then((value) {
                                addEmployee(employeeProvider, value['id'], nameController.text,
                                    int.parse(hourlyRateController.text));
                                Navigator.pop(context);
                              }).catchError((e) {
                                print(e);
                              });
                            },
                          ),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ));
  }

  bool updated = false;
  @override
  Widget build(BuildContext context) {
    // bool updateToggle = Provider.of<DataUpdateProvider>(context, listen: true).updateToggle;

    return Consumer<EmployeesProvider>(
        builder: (BuildContext context, EmployeesProvider value, Widget? child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomSearchBar(),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    itemCount: value.searchName == 'all' ? value.employees.length : value.searchQuery.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: value.searchName == 'all'
                            ? employeeTile(
                                id: value.employees[index]['id'],
                                name: value.employees[index]['name'],
                                hourlyRate: value.employees[index]['hourly_rate'],
                                date: value.employees[index]['date'],
                                timeIn: value.employees[index]['time_in'],
                                timeOut: value.employees[index]['time_out'],
                              )
                            : employeeTile(
                                id: value.searchQuery[index]['id'],
                                name: value.searchQuery[index]['name'],
                                hourlyRate: value.searchQuery[index]['hourly_rate'],
                                date: value.searchQuery[index]['date'],
                                timeIn: value.searchQuery[index]['time_in'],
                                timeOut: value.searchQuery[index]['time_out'],
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openCreationForm(value);
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
