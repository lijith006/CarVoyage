import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/rented_cars.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_project_final/db_functions/car_db_functions.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/home_screen.dart';
import 'package:flutter_project_final/components/custom_text_field.dart';

class AddCustomerDetails extends StatefulWidget {
  final CarsModel car;
  final String pickUpDate;
  final String dropOffDate;
  final String initialkilometers;

  const AddCustomerDetails(
      {Key? key,
      required this.car,
      required this.pickUpDate,
      required this.dropOffDate,
      required this.initialkilometers})
      : super(key: key);

  @override
  State<AddCustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<AddCustomerDetails> {
  final kilometersController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerNumberController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final dropOffDateController = TextEditingController();
  String? licenseImage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Customer Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
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
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_box_outlined),
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: licenseImage != null
                          ? FileImage(File(licenseImage!))
                          : const AssetImage('assets/Images/grey.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: licenseImage == null
                      ? const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: 40,
                        )
                      : const SizedBox(),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: customerNameController,
                      hintText: 'Enter Customer name',
                      labelText: 'Customer Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: customerNumberController,
                      hintText: 'Enter phone number',
                      labelText: 'Phone Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a mobile number';
                        }
                        if (value.length != 10) {
                          return 'Mobile number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Enter License Number',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'License Number',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: licenseNumberController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a license number';
                        }
                        if (!RegExp(r'^[A-Z]{2}\d{2}\d{4}\d{7}$')
                            .hasMatch(value)) {
                          return 'Invalid license number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          removedCar(widget.car);
                          await saveRentOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Car rented out successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RentedCar(),
                              ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 182, 214, 135),
                        foregroundColor: const Color.fromARGB(255, 6, 6, 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 10,
                        ),
                      ),
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Rent'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveRentOut() async {
    final carBrand = widget.car.brand;
    final carModel = widget.car.model;
    final carMonthlyRent = widget.car.amount;
    final customerName = customerNameController.text.trim();
    final contactNumber = customerNumberController.text.trim();
    final licenseNumber = licenseNumberController.text.trim();
    final pickUpDate = widget.pickUpDate;
    final dropOffDate = widget.dropOffDate;
    final selectedImage = widget.car.selectedImage;
    final carImage = widget.car.selectedImage;
    final pollutionCertImage = widget.car.pollutionCertImage;
    final insuranceCertImage = widget.car.InsuranceCertImage;
    final kilometers = widget.initialkilometers;
    final carFuel = widget.car.fuel;
    final carSeat = widget.car.seat;

    if (carModel.isEmpty ||
        carBrand.isEmpty ||
        carMonthlyRent.isEmpty ||
        customerName.isEmpty ||
        contactNumber.isEmpty ||
        licenseNumber.isEmpty ||
        carSeat.isEmpty ||
        carFuel.isEmpty ||
        pickUpDate.isEmpty ||
        dropOffDate.isEmpty ||
        selectedImage.isEmpty ||
        pollutionCertImage.isEmpty ||
        insuranceCertImage.isEmpty ||
        kilometers.isEmpty ||
        carImage.isEmpty ||
        licenseImage == null) {
      return;
    }

    final customerOne = CustomerModel(
        customerName: customerName,
        contactNumber: contactNumber,
        licenseNumber: licenseNumber,
        pickUpDate: pickUpDate,
        dropOffDate: dropOffDate,
        licenseImage: licenseImage!,
        carFuel: carFuel,
        carSeat: carSeat,
        carBrand: carBrand,
        carModel: carModel,
        carMonthlyRent: carMonthlyRent,
        kilometers: kilometers,
        carImage: carImage);

    await CustomerAdd(customerOne);

    Navigator.pop(context);
  }

  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    } else {
      setState(() {
        licenseImage = image.path;
      });
    }
  }
}
