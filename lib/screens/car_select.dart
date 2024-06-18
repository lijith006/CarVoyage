import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/components/custom_elevated_all.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/addcustomer_details.dart';
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

class _CarSelectState extends State<CarSelect> {
  final initialKilometersController = TextEditingController();
  final pickUpDateController = TextEditingController();

  final dropOffDateController = TextEditingController();
  @override
  void dispose() {
    initialKilometersController.dispose();
    pickUpDateController.dispose();
    dropOffDateController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
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
        appBar: CustomAppBar(
          title: 'Car Selection',
        ),
        backgroundColor: Color.fromARGB(115, 50, 49, 49),
        bottomNavigationBar: buildCustomBottomAppBar(
          context: context,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
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
                  keyboardType: TextInputType.number,
                  hintText: 'Enter the Kilometers',
                  labelText: 'Initial Kilometer',
                  controller: initialKilometersController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
                CustomButtonAll(
                  icon: Icons.save,
                  label: 'Add user details',
                  onPressed: () {
                    if (_formKey.currentState!.validate() && validateDates()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddCustomerDetails(
                            car: widget.car,
                            initialkilometers: initialKilometersController.text,
                            pickUpDate: pickUpDateController.text,
                            dropOffDate: dropOffDateController.text,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ]),
            ),
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
      if (dropOffDateController.text.isNotEmpty) {
        DateTime dropOffDate =
            DateFormat('dd/MM/yyyy').parse(dropOffDateController.text);
        if (picked.isAfter(dropOffDate)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Pick-up date cannot be after drop-off date'),
            backgroundColor: Colors.red,
          ));
          return;
        }
      }
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
