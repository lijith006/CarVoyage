import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/dropoff_details.dart';
import 'package:flutter_project_final/screens/home_screen.dart';

class RentedCarDetails extends StatefulWidget {
  final CustomerModel customer;

  const RentedCarDetails({
    Key? key,
    required this.customer,
  }) : super(key: key);
  @override
  State<RentedCarDetails> createState() => _RentedCarDetailsState();
}

class _RentedCarDetailsState extends State<RentedCarDetails> {
  @override
  void initState() {
    super.initState();
    print('Initial Kilometers details: ${widget.customer.initialkilometers}');
  }

  Widget SelectedCarImage() {
    return SizedBox(
      height: 220,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.customer.carImage.isNotEmpty
                ? Image.file(
                    File(widget.customer.carImage),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 220,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

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
              width: 50,
            ),
            Text(
              'Rented Cars Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SelectedCarImage(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow('Customer name:', widget.customer.customerName),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Contact number:', widget.customer.contactNumber),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('License number:', widget.customer.licenseNumber),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('PickUp Date:', widget.customer.pickUpDate),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('DropOff Date:', widget.customer.dropOffDate),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Car Brand:', widget.customer.carBrand),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Car Model:', widget.customer.carModel),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Fuel:', widget.customer.carFuel),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Seat:', widget.customer.carSeat),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow('Car Rent:', widget.customer.dailyRent,
                      isRupee: true),
                  SizedBox(
                    height: 10,
                  ),
                  buildRow(
                      'Initial Kilometers:', widget.customer.initialkilometers),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'License Image:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: widget.customer.licenseImage.isNotEmpty
                  ? Image.file(
                      File(widget.customer.licenseImage),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 220,
                    )
                  : Container(),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController currentKilometersController =
                                TextEditingController();
                            return AlertDialog(
                              title: Text('Enter Current Kilometers'),
                              content: TextField(
                                controller: currentKilometersController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Current Kilometers'),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Submit'),
                                  onPressed: () {
                                    String currentKilometers =
                                        currentKilometersController.text;
                                    widget.customer.currentKilometers =
                                        currentKilometers;
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DropoffDetails(
                                          customer: widget.customer,
                                          currentKilometers: currentKilometers,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.key_off_outlined, size: 18),
                    label: Text(
                      'Rent off',
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 182, 214, 135),
                      foregroundColor: Color.fromARGB(255, 6, 6, 6),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            )
          ],
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
