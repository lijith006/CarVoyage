import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/rented_cars_details.dart';
import 'package:hive_flutter/adapters.dart';

enum CarStatus {
  available,
  rented,
  due,
  upcomingDue,
}

class DueCarsPAge extends StatelessWidget {
  CarStatus getCarStatus(CustomerModel customer) {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(Duration(days: 1));
    final DateTime due = parseDate(customer.dropOffDate);
    //final DateTime upcomingDue = due.subtract(Duration(days: 3));
    if (due.isBefore(yesterday)) {
      return CarStatus.due;
      // } else if (upcomingDue.isBefore(now)) {
      //return CarStatus.upcomingDue;
    } else {
      return CarStatus.rented;
    }
  }

//Converting  Date Format------------------------------------
  DateTime parseDate(String dateString) {
    final parts = dateString.split('/');
    if (parts.length != 3) {
      throw FormatException('Invalid date format', dateString);
    }
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  List<CustomerModel> filterDueCars() {
    final customerDB = Hive.box<CustomerModel>('customer_cu2');
    final List<CustomerModel> allCustomer = customerDB.values.toList();
    return allCustomer
        .where((customer) => getCarStatus(customer) == CarStatus.due)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<CustomerModel> dueCars = filterDueCars();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Due Cars',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(115, 50, 49, 49),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Color.fromARGB(115, 50, 49, 49),
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                child: Container(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    'lib/icons/house.png',
                    color: Color.fromARGB(255, 147, 247, 150),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: dueCars.isEmpty
            ? Center(
                child: Text(
                  'No due cars found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: dueCars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RentedCarDetails(
                            customer: dueCars[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Color.fromARGB(115, 110, 105, 105),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(dueCars[index].carImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                dueCars[index].carBrand,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
