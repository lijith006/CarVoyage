import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/components/custom_drop_down.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCar extends StatefulWidget {
  final CarsModel modelcar;
  const UpdateCar({
    super.key,
    required this.modelcar,
  });

  @override
  State<UpdateCar> createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  var brandController = TextEditingController();
  var yearController = TextEditingController();
  var modelNameController = TextEditingController();
  var InsuranceController = TextEditingController();
  var amountController = TextEditingController();
  var insuranceDateController = TextEditingController();
  File? image25;
  String? seat;
  String? fuel;
  String? selectedImage;
  @override
  void initState() {
    brandController = TextEditingController();
    yearController = TextEditingController();
    modelNameController = TextEditingController();
    InsuranceController = TextEditingController();
    amountController = TextEditingController();
    insuranceDateController = TextEditingController();
    image25 = null;
    seat = null;
    fuel = null;
    selectedImage = null;
    brandController.text = widget.modelcar.brand;
    yearController.text = widget.modelcar.year;
    modelNameController.text = widget.modelcar.model;
    InsuranceController.text = widget.modelcar.insurance;
    amountController.text = widget.modelcar.amount;
    insuranceDateController.text = widget.modelcar.insurance;
    seat = widget.modelcar.seat;
    fuel = widget.modelcar.fuel;
    selectedImage = widget.modelcar.selectedImage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Update Cars',
        ),
        backgroundColor: Color.fromARGB(115, 50, 49, 49),
        bottomNavigationBar: buildCustomBottomAppBar(
          context: context,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            GestureDetector(
              onTap: () {
                getimage(ImageSource.gallery);
              },
              child: Container(
                height: 200,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: image25 != null
                        ? FileImage(image25!)
                        : const AssetImage('assets/Images/grey.jpg')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: image25 == null
                    ? const Icon(Icons.add_a_photo_outlined,
                        color: Colors.white, size: 40)
                    : SizedBox(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hintText: 'Brand',
                labelText: 'Brand',
                controller: brandController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hintText: 'Model',
                labelText: 'Model',
                controller: modelNameController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                hintText: 'Year',
                labelText: 'Year',
                controller: yearController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hintText: 'Insurance',
                labelText: 'Insurance',
                controller: InsuranceController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                hintText: 'Amount',
                labelText: 'Amount',
                controller: amountController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: customDropdownField(
                  labelText: 'Seat',
                  hintText: 'Seat',
                  value: seat,
                  items: ['2', '5', '7', '10'],
                  onChanged: (String? value) {
                    setState(() {
                      seat = value;
                    });
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: customDropdownField(
                    labelText: 'Fuel',
                    hintText: 'Fuel',
                    value: fuel,
                    items: [
                      'Petrol',
                      'Diesel',
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        fuel = value;
                      });
                    })),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  widget.modelcar.brand = brandController.text;
                  widget.modelcar.model = modelNameController.text;
                  widget.modelcar.year = yearController.text;
                  widget.modelcar.amount = amountController.text;
                  widget.modelcar.seat = seat ?? "";
                  widget.modelcar.fuel = fuel ?? "";

                  widget.modelcar.selectedImage = selectedImage ?? "";

                  await widget.modelcar.save();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Car updated succesfully')));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 182, 214, 135),
                  foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                ),
                icon: const Icon(Icons.save_outlined),
                label: const Text('Update'),
              ),
            ),
          ]),
        ));
  }

  Future<void> insuranceDatePicker() async {
    DateTime? pickedinsurance = await showDatePicker(
        context: context,
        firstDate: DateTime(2010),
        lastDate: DateTime(2099),
        initialDate: DateTime.now());
    if (pickedinsurance != null) {
      setState(() {
        insuranceDateController.text = pickedinsurance.toString().split(" ")[0];
      });
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      image25 = File(image.path);
    });
  }
}
