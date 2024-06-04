import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/rented_cars_details.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RentedCar extends StatefulWidget {
  final CustomerModel? customer;
  final String? initialkilometers;
  const RentedCar({
    super.key,
    this.customer,
    this.initialkilometers,
  });

  @override
  State<RentedCar> createState() => _RentedCarState();
}

class _RentedCarState extends State<RentedCar> {
  String? selectedImage;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rented Cars',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Colors.black45,
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
        body: ValueListenableBuilder<Box<CustomerModel>>(
            valueListenable: Boxes.getCustomerData().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<CustomerModel>();
              if (data.isEmpty) {
                return Center(
                  child: Text('No RentOut Cars'),
                );
              } else {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RentedCarDetails(
                                  car: data[index],
                                  customer: data[index],
                                  initialkilometers: widget.initialkilometers),
                            ));
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
                                    File(data[index].carImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  data[index].carBrand,
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
                );
              }
            }));
  }
}
