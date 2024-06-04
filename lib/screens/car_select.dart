import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/addcustomer_details.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';
import 'package:intl/intl.dart';

class CarSelect extends StatefulWidget {
  final CarsModel car;

  const CarSelect({
    super.key,
    required this.car,
  });

  @override
  State<CarSelect> createState() => _CarSelectState();
}

final initialKilometersController = TextEditingController();
final pickUpDateController = TextEditingController();

final dropOffDateController = TextEditingController();

class _CarSelectState extends State<CarSelect> {
  Widget selectedCarImage() {
    return imageCard(widget.car.selectedImage);
  }

  Widget pollutionCertImage() {
    return imageCard(widget.car.pollutionCertImage);
  }

  Widget insuranceCertImage() {
    return imageCard(widget.car.InsuranceCertImage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                'CAR SELECTION',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: selectedCarImage(),
              ),
              const SizedBox(height: 40),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Brand',
                labelText: 'Brand',
                readOnly: true,
                initialValue: widget.car.brand,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Model',
                labelText: 'Model',
                readOnly: true,
                initialValue: widget.car.model,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Year',
                labelText: 'Year',
                readOnly: true,
                initialValue: widget.car.year,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Insurance',
                labelText: 'Insurance',
                readOnly: true,
                initialValue: widget.car.insurance,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Amount',
                labelText: 'Amount',
                readOnly: true,
                initialValue: widget.car.amount,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Seat',
                labelText: 'Seat',
                readOnly: true,
                initialValue: widget.car.seat,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Fuel',
                labelText: 'Fuel',
                readOnly: true,
                initialValue: widget.car.fuel,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                readOnly: true,
                hintText: 'Pickup date',
                labelText: 'Pickup date',
                controller: pickUpDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pick a date';
                  }
                  return null;
                },
                onTap: () async {
                  pickUpDateSelected();
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                readOnly: true,
                hintText: 'Drop Off date',
                labelText: 'Drop Off date',
                controller: dropOffDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pick a date';
                  }
                  return null;
                },
                onTap: () async {
                  dropOffDateSelected();
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Enter the Kilometers',
                labelText: 'Initial Kilometer',
                controller: initialKilometersController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kilometers  is required';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Pollution Certificate',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              pollutionCertImage(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Insurance Certificate',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              insuranceCertImage(),
              const SizedBox(height: 20),
              //***************************************** */
              ElevatedButton.icon(
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    ),
                    foregroundColor: MaterialStatePropertyAll(Colors.black),
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 182, 214, 135),
                    )),
                onPressed: () {
                  if (validateDates()) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddCustomerDetails(
                          car: widget.car,
                          initialkilometers: initialKilometersController.text,
                          pickUpDate: pickUpDateController.text,
                          dropOffDate: dropOffDateController.text),
                    ));
                  }
                },
                icon: const Icon(Icons.save, color: Colors.black),
                label: const Text(
                  'Add user details',
                ),
              ),
            ]),
          ),
        ));
  }

  Future<void> pickUpDateSelected() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2099),
        initialDate: DateTime.now());
    if (picked != null) {
      setState(() {
        pickUpDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> dropOffDateSelected() async {
    DateTime? dropdatepick = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2099),
        initialDate: DateTime.now());
    if (dropdatepick != null) {
      DateTime pickUpDate =
          DateFormat('dd/MM/yyyy').parse(pickUpDateController.text);
      if (dropdatepick.isBefore(pickUpDate)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Drop-off date cannot be before pick-up date'),
          backgroundColor: Colors.red,
        ));
      } else {
        setState(() {
          dropOffDateController.text =
              DateFormat('dd/MM/yyyy').format(dropdatepick);
          // dropOffDateController.text = dropdatepick.toString().split(" ")[0];
        });
      }
    }
  }

  bool validateDates() {
    if (pickUpDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a pick-up date'),
        ),
      );
      return false;
    }
    if (dropOffDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a drop-off date'),
      ));
      return false;
    }
    DateTime pickUpDate =
        DateFormat('dd/MM/yyyy').parse(pickUpDateController.text);
    DateTime dropOffDate =
        DateFormat('dd/MM/yyyy').parse(dropOffDateController.text);
    if (dropOffDate.isBefore(pickUpDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Drop-off date cannot be before pick-up date'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }
}
