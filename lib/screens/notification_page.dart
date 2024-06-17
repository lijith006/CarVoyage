import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/db_functions/car_db_functions.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter_project_final/screens/rented_cars_details.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  final String carModel;
  final String customerName;
  final String customerContact;
  final String selectedImage;
  final int daysLate;
  NotificationModel(
      {required this.carModel,
      required this.customerName,
      required this.customerContact,
      required this.daysLate,
      required this.selectedImage});
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notificationList = [];
  @override
  void initState() {
    super.initState();
    getAllCustomers();
    customerListNotifier.addListener(_onCustomerListChanged);
  }

  @override
  void dispose() {
    customerListNotifier.removeListener(_onCustomerListChanged);
    super.dispose();
  }

  void _onCustomerListChanged() {
    generateNotifications(customerListNotifier.value);
  }

  void generateNotifications(List<CustomerModel> customerList) {
    DateTime currentDate = DateTime.now();
    notificationList.clear();
    for (var customer in customerList) {
      DateTime dropOffDate =
          DateFormat('dd/MM/yyyy').parse(customer.dropOffDate);
      if (dropOffDate.isBefore(currentDate)) {
        int daysLate = currentDate.difference(dropOffDate).inDays;
        if (daysLate > 0) {
          NotificationModel notification = NotificationModel(
              carModel: customer.carModel,
              customerName: customer.customerName,
              customerContact: customer.contactNumber,
              daysLate: daysLate,
              selectedImage: customer.carImage);
          notificationList.add(notification);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      bottomNavigationBar: buildCustomBottomAppBar(
        context: context,
      ),
      body: ValueListenableBuilder(
          valueListenable: Boxes.getCustomerData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<CustomerModel>();
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No Notifications',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    NotificationModel notification = notificationList[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Card(
                        color: Color.fromARGB(255, 78, 76, 76),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    RentedCarDetails(customer: data[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(notification.selectedImage)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${notification.customerName} is late for ${notification.daysLate}  DAYS',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'CAR : ${notification.carModel}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 147, 247, 150)),
                                      ),
                                      const SizedBox(height: 15),
                                      GestureDetector(
                                        child: Row(
                                          children: [
                                            const Gap(30),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: 'CALL NOW : ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: notification
                                                        .customerContact,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 180, 171, 225),
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        onTap: () async {
                                          await FlutterPhoneDirectCaller
                                              .callNumber(
                                                  notification.customerContact);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
