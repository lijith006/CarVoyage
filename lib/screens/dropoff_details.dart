import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/components/custom_elevated_all.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/db_functions/car_db_functions.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class DropoffDetails extends StatefulWidget {
  final CustomerModel customer;
  final CarsModel? car;
  const DropoffDetails({
    super.key,
    required this.customer,
    this.car,
    required currentKilometers,
  });

  @override
  State<DropoffDetails> createState() => _DropoffDetailsState();
}

class _DropoffDetailsState extends State<DropoffDetails> {
  double drivenKilometers = 0;
  final initialKilometersController = TextEditingController();
  final currentKilometersController = TextEditingController();
  final drivenKilometersController = TextEditingController();
  var carbrandController = TextEditingController();
  var carmodelController = TextEditingController();

  var customerNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var licenseNumberController = TextEditingController();
  var pickUpDate = TextEditingController();
  var dropOffDate = TextEditingController();
  var dailyRentController = TextEditingController();
  var carseater = TextEditingController();
  var carfuel = TextEditingController();
  double totalRent = 0.0;
  String? selectedImage;
  File? imagepath;
  @override
  void initState() {
    currentKilometersController.text = widget.customer.currentKilometers;
    drivenKilometersController.text = '0';
    initialKilometersController.text = widget.customer.initialkilometers;
    print('initial kilometer in dropoff:${widget.customer.initialkilometers}');
    print('CuRRENT kilometer in dropoff:${widget.customer.currentKilometers}');

    carbrandController.text = widget.customer.carBrand;
    carmodelController.text = widget.customer.carModel;

    customerNameController.text = widget.customer.customerName;
    mobileNumberController.text = widget.customer.contactNumber;
    licenseNumberController.text = widget.customer.licenseNumber;
    selectedImage = widget.customer.carImage;
    pickUpDate.text = widget.customer.pickUpDate;
    dropOffDate.text = widget.customer.dropOffDate;
    dailyRentController.text = widget.customer.dailyRent;
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
    if (initialKilometersController.text.isNotEmpty &&
        currentKilometersController.text.isNotEmpty) {
      double initialKilometer = double.parse(initialKilometersController.text);
      double currentKilometer = double.parse(currentKilometersController.text);
      if (currentKilometer >= initialKilometer) {
        drivenKilometers = currentKilometer - initialKilometer;
      } else {
        drivenKilometers = 0;
      }
      drivenKilometersController.text = drivenKilometers.toString();
      totalRent = calculateTotalRent(
          drivenKilometers, double.parse(dailyRentController.text));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getCustomerData().listenable(),
        builder: (context, box, _) {
          return ValueListenableBuilder<Box<CarsModel>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, carBox, _) {
              return Scaffold(
                appBar: CustomAppBar(
                  title: 'Drop off details',
                ),
                backgroundColor: Color.fromARGB(5, 255, 255, 255),
                bottomNavigationBar: buildCustomBottomAppBar(
                  context: context,
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
                          controller: dailyRentController,
                          enabled: false,
                        ),
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
                        const Gap(15),
                        SizedBox(
                          height: 20,
                        ),
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
                            'Total Rent: \₹${totalRent.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(15),
                        CustomButtonAll(
                          label: 'Submit',
                          onPressed: () {
                            Navigator.pop(context);
                            removeCustomerFromScreen(widget.customer);
                            saveDetails();
                            verifyCarAdded();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
//****************Snackbar */
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'The car has been rented off successfully!'),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,
                              ),
                            );

                            print('Result Rent:${totalRent}');
                          },
                        ),
                      ],
                    )),
                  ),
                ),
              );
            },
          );
        });
  }

  saveDetails() {
    final brandName = widget.customer.carBrand;
    final carModel = widget.customer.carModel;
    final carYear = widget.customer.carYear;
    final carSeat = widget.customer.carSeat;
    final carFuel = widget.customer.carFuel;
    final carRent = widget.customer.dailyRent;
    final carInsurance = widget.customer.carInsurance;
    final carImage = widget.customer.carImage;
    final carPollutionCertificate = widget.customer.carPollutionCert;
    final carInsuranceCertificate = widget.customer.carInsuranceCert;
    final cars = CarsModel(
        selectedImage: carImage,
        model: carModel,
        year: carYear,
        insurance: carInsurance,
        amount: carRent,
        seat: carSeat,
        fuel: carFuel,
        brand: brandName,
        pollutionCertImage: carPollutionCertificate,
        InsuranceCertImage: carInsuranceCertificate);
    addCar(cars);
  }

  double calculateTotalRent(double drivenKilometers, double dailyRent) {
    double perDayRent = dailyRent;
    DateTime pickup =
        DateFormat('dd/MM/yyyy').parse(widget.customer.pickUpDate);
    DateTime dropoff =
        DateFormat('dd/MM/yyyy').parse(widget.customer.dropOffDate);
    int differenceInDays = dropoff.difference(pickup).inDays;
    if (differenceInDays == 0) {
      differenceInDays = 1;
    }
    ;
    double totalRent = perDayRent * differenceInDays;

    if (drivenKilometers > 500) {
      double extraKilometers = drivenKilometers - 500;
      totalRent += (extraKilometers / 100) * 100;
    }
    return totalRent;
  }
}
