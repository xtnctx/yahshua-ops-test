import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/employee_provider.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final nameController = TextEditingController();
  final hourlyRateController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'all';
    hourlyRateController.text = '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
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
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.only(left: 20.0),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

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
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Hourly Rate',
                contentPadding: EdgeInsets.only(left: 20.0),
              ),
            ),
          ),
        ),

        // Sign in button
        Consumer<EmployeesProvider>(
          builder: (BuildContext context, EmployeesProvider value, Widget? child) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  value.searchName = nameController.text;
                  value.searchRate =
                      hourlyRateController.text.isNotEmpty ? int.parse(hourlyRateController.text) : 0;
                  value.searchByNameAndRate();
                },
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}
