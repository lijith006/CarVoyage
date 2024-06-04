import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/db_functions/car_db_functions.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/car_select.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/screens/update_car.dart';
import 'package:hive_flutter/hive_flutter.dart';

class cardetails extends StatefulWidget {
  final CarsModel modelcar;

  cardetails({
    super.key,
    required this.modelcar,
  });
  @override
  State<cardetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<cardetails> {
  var brandController = TextEditingController();
  var modelNameController = TextEditingController();
  var yearController = TextEditingController();
  var insuranceController = TextEditingController();
  var amountController = TextEditingController();

  //File? imagepath;
  String? selectedImage;
  String? fuel;
  String? seat;
  Widget selectedCarImage() {
    return imageCard(widget.modelcar.selectedImage);
  }

  Widget pollutionCertImage() {
    return imageCard(widget.modelcar.pollutionCertImage);
  }

  Widget insuranceCertImage() {
    return imageCard(widget.modelcar.InsuranceCertImage);
  }

  Widget imageCard(String imagePath) {
    return SizedBox(
      height: 220,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: imagePath.isNotEmpty
                  ? Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 220,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget SelectedCarImage() {
  //   return SizedBox(
  //     height: 220,
  //     width: 200,
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       elevation: 5,
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: Colors.grey,
  //             ),
  //           ),
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: widget.modelcar.selectedImage.isNotEmpty
  //                 ? Image.file(
  //                     File(widget.modelcar.selectedImage),
  //                     fit: BoxFit.cover,
  //                     width: 200,
  //                     height: 220,
  //                   )
  //                 : Container(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Row(
          children: [
            SizedBox(
              width: 65,
            ),
            Text(
              'CARS DETAILS',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(0, 150, 232, 19),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(5, 255, 255, 255),
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
      body: ValueListenableBuilder<Box<CarsModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: selectedCarImage(),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(5, 255, 255, 255),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              buildRow('Brand', widget.modelcar.brand),
                              SizedBox(
                                height: 10,
                              ),
                              buildRow('Model', widget.modelcar.model),
                              SizedBox(
                                height: 10,
                              ),
                              buildRow('Year', widget.modelcar.year),
                              SizedBox(
                                height: 10,
                              ),
                              buildRow('Fuel', widget.modelcar.fuel),
                              SizedBox(
                                height: 10,
                              ),
                              buildRow('Seat', widget.modelcar.seat),
                              SizedBox(
                                height: 10,
                              ),
                              buildRow('Rent', widget.modelcar.amount,
                                  isRupee: true),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Pollution Certificate',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              pollutionCertImage(),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  'Insurance Certificate',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                              insuranceCertImage(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Deletion"),
                                  content: const Text(
                                      "Are you sure you want to delete this car?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("CANCEL"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deletecar(widget.modelcar);
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'The car has been successfully deleted'),
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                      child: const Text("DELETE"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 182, 214, 135),
                            foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 10),
                            elevation: 3,
                          ),
                          child: const Text('DELETE'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CarSelect(
                                  car: widget.modelcar,
                                ),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 182, 214, 135),
                                foregroundColor:
                                    const Color.fromARGB(255, 6, 6, 6),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 10),
                                elevation: 3),
                            child: Text('SELECT')),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            editCar(
                                widget.modelcar,
                                widget.modelcar.brand.toString(),
                                widget.modelcar.model.toString(),
                                widget.modelcar.year.toString(),
                                widget.modelcar.fuel.toString(),
                                widget.modelcar.seat.toString(),
                                widget.modelcar.amount.toString(),
                                widget.modelcar.insurance.toString(),
                                widget.modelcar.selectedImage.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 182, 214, 135),
                            foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 10),
                            elevation: 3,
                          ),
                          child: const Text('UPDATE'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<void> editCar(
    CarsModel modelcar,
    String brand,
    String model,
    String year,
    String fuel,
    String seat,
    String insurance,
    String amount,
    String carImage,
  ) async {
    brandController.text = brand;
    modelNameController.text = model;
    yearController.text = year;
    fuel = fuel;
    seat = seat;
    selectedImage = carImage;
    insuranceController.text = insurance;
    amountController.text = amount;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateCar(
          modelcar: modelcar,
        ),
      ),
    );
  }

  Widget buildRow(String label, String value, {bool isRupee = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        Expanded(
            child: Text(
          isRupee ? '\₹${value}' : value,
          style: TextStyle(
              color: Color.fromARGB(255, 147, 247, 150), fontSize: 17),
          textAlign: TextAlign.right,
        ))
      ],
    );
  }
}
