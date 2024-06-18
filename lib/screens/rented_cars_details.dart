import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/components/custom_elevated_all.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/dropoff_details.dart';

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

  Future<void> makePhoneCall(String phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Rented Car Details',
      ),
      backgroundColor: Color.fromARGB(5, 255, 255, 255),
      bottomNavigationBar: buildCustomBottomAppBar(
        context: context,
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
                  GestureDetector(
                    onTap: () async {
                      await makePhoneCall(widget.customer.contactNumber);
                    },
                    child: buildRow(
                      'Contact number:',
                      widget.customer.contactNumber,
                      valueColor: Colors.cyan,
                    ),
                  ),
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
              child: CustomButtonAll(
                icon: Icons.key_off_outlined,
                label: 'Rent off',
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
                            decoration:
                                InputDecoration(hintText: 'Current Kilometers'),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value,
      {bool isRupee = false, Color? valueColor}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        Expanded(
            child: Text(
          isRupee ? '\₹${value}' : value,
          style: TextStyle(color: valueColor ?? Colors.yellow, fontSize: 17),
          textAlign: TextAlign.right,
        ))
      ],
    );
  }
}
