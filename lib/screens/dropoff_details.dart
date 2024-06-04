import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';

class DropoffDetails extends StatefulWidget {
  final CustomerModel customer;
  final CarsModel? car;
  final CustomerModel initialkilometers;
  const DropoffDetails(
      {super.key,
      required this.customer,
      this.car,
      required this.initialkilometers});

  @override
  State<DropoffDetails> createState() => _DropoffDetailsState();
}

class _DropoffDetailsState extends State<DropoffDetails> {
  int drivenKilometers = 0;
  final usedKilometersController = TextEditingController();
  final currentKilometersController = TextEditingController();
  final drivenKilometersController = TextEditingController();
  var carbrandController = TextEditingController();
  var carmodelController = TextEditingController();

  var customerNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var pickUpDate = TextEditingController();
  var dropOffDate = TextEditingController();
  var kilometersController = TextEditingController();
  var dailyrentController = TextEditingController();
  var carseater = TextEditingController();
  var carfuel = TextEditingController();
  double totalRent = 0.0;
  String? selectedImage;
  File? imagepath;
  @override
  void initState() {
    kilometersController.text = widget.customer.kilometers;
    carbrandController.text = widget.customer.carBrand;
    carmodelController.text = widget.customer.carModel;

    customerNameController.text = widget.customer.customerName;
    mobileNumberController.text = widget.customer.contactNumber;
    licenseNumberController.text = widget.customer.licenseNumber;
    selectedImage = widget.customer.carImage;
    pickUpDate.text = widget.customer.pickUpDate;
    dropOffDate.text = widget.customer.dropOffDate;
    dailyrentController.text = widget.customer.carMonthlyRent;
    carfuel.text = widget.customer.carFuel;
    carseater.text = widget.customer.carSeat;
    updateTotalRent();
    super.initState();
  }

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: selectedImage != null && selectedImage!.isNotEmpty
                ? Image.file(
                    File(selectedImage!),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  void updateTotalRent() {
    if (kilometersController.text.isNotEmpty) {
      double kilometers = double.parse(kilometersController.text);
      totalRent = calculateTotalRent(
          kilometers, double.parse(dailyrentController.text));
      setState(() {});
    }
  }

  // Future<void> markAsAvailable(CarsModel car) async {
  //   car.status = 'available';
  //   await car.save();
  //   setState(() {
  //     carListNotifier.value.add(car);
  //     carListNotifier.notifyListeners();
  //   // })
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder: (context, box, _) {
          return ValueListenableBuilder<Box<CarsModel>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, carBox, _) {
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
                        'DROP OFF DETAILS',
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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                        child: Column(
                      children: [
                        _buildSelectedImage(),
                        Gap(15),
                        CustomTextField(
                          labelText: 'Car Brand',
                          hintText: 'Car Brand',
                          controller: carbrandController,
                          enabled: false,
                        ),
                        Gap(15),
                        CustomTextField(
                          labelText: 'Car Model',
                          hintText: 'Car Model',
                          controller: carmodelController,
                          enabled: false,
                        ),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'Daily Rent',
                          hintText: 'Daily Rent',
                          controller: dailyrentController,
                          enabled: false,
                        ),
                        const Gap(15),
                        // CustomTextField(
                        //   labelText: 'Car Reg Number',
                        //   hintText: 'Car Reg Number',
                        //   controller: carRegController,
                        //   enabled: false,
                        //   textStyle: const TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'Customer Name',
                          hintText: 'Customer Name',
                          controller: customerNameController,
                          enabled: false,
                        ),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'Mobile Number',
                          hintText: 'Mobile Number',
                          controller: mobileNumberController,
                          enabled: false,
                        ),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'License Number',
                          hintText: 'License Number',
                          controller: licenseNumberController,
                          enabled: false,
                        ),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'Pick-up Date',
                          hintText: 'Pick-up Date',
                          controller: pickUpDate,
                          enabled: false,
                        ),
                        const Gap(15),
                        CustomTextField(
                          labelText: 'Drop-Off Date',
                          hintText: 'Drop-Off Date',
                          controller: dropOffDate,
                          enabled: false,
                        ),
                        const Gap(15),

                        CustomTextField(
                          labelText: 'Current Kilometers ',
                          hintText: 'Current Kilometers',
                          initialValue: currentKilometersController.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Current Kilometers is required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            updateTotalRent();
                            // setState(() {
                            //   int initialKilometers = int.parse(widget.);
                            //   int currentKilometers = int.parse(value);
                            //   drivenKilometers =
                            //       currentKilometers - initialKilometers;
                            // });
                          },
                          // onChanged: (value) => updateTotalRent(),
                        ),

                        const Gap(15),

                        // CustomTextField(
                        //   hintText: 'Driven Kilometers',
                        //   labelText: 'Driven Kilometers',
                        //   controller: drivenKilometersController,
                        //   keyboardType: TextInputType.number,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Driven kilometers is required';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        SizedBox(
                          height: 20,
                        ),

                        // ElevatedButton(
                        //   onPressed: () async {
                        //     if (car != null) {
                        //       await markAsAvailable(car);
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content: Text('Car marked as available!')),
                        //       );
                        //       Navigator.of(context).pop();
                        //     }
                        //   },
                        //   child: Text('Rent Off'),
                        // ),
                        //  onPressed: calculateDrivenKilometers,
                        //child: const Text('Calculate Driven Kilometers'),

                        const SizedBox(height: 20),
                        Text(
                          'Driven Kilometers: ${drivenKilometers}',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          color: Colors.grey[150],
                          child: Text(
                            'total Rent: $totalRent',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Gap(15),
                        ElevatedButton(
                            onPressed: () {},
                            child: Text('OK'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 182, 214, 135),
                              foregroundColor:
                                  const Color.fromARGB(255, 6, 6, 6),
                              padding: EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 10,
                              ),
                            ))
                      ],
                    )),
                  ),
                ),
              );
            },
          );
        });
  }

  // String calculateDrivenKilometers() {
  //   if (usedKilometersController.text.isEmpty) {
  //     return '0';
  //   }
  //   final initialKilometers = int.tryParse(widget.customer.kilometers) ?? 0;
  //   final currentKilometers =
  //       int.tryParse(currentKilometersController.text) ?? 0;
  //   final drivenKilometers = currentKilometers - initialKilometers;
  //   return drivenKilometers.toString();
  // }
//************************************************************** */
  // void calculateDrivenKilometers() {
  //   if (usedKilometersController.text.isEmpty) {
  //     drivenKilometersController.text = '0';
  //     return;
  //   }
  //   final initialKilometers = int.tryParse(widget.customer.kilometers) ?? 0;
  //   final currentKilometers = int.tryParse(usedKilometersController.text) ?? 0;
  //   final drivenKilometers = currentKilometers - initialKilometers;
  //   drivenKilometersController.text = drivenKilometers.toString();
  // }
}

double calculateTotalRent(double drivenKilometers, double dailyRent) {
  double totalRent = 0;

  if (drivenKilometers <= 200) {
    totalRent = dailyRent;
  } else {
    totalRent = dailyRent;
    double additionalKilometers = drivenKilometers - 200;
    totalRent += (additionalKilometers / 100) * 100;
  }
  return totalRent;
}
