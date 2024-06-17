import 'dart:io';
import 'package:flutter_project_final/components/appbar.dart';
import 'package:flutter_project_final/components/bottom_app_bar.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/cars_details.dart';
import 'package:flutter_project_final/screens/search_filter.dart';
import 'package:hive_flutter/adapters.dart';

class AllCarList extends StatefulWidget {
  final File? imagex;
  const AllCarList({super.key, this.imagex});

  @override
  State<AllCarList> createState() => _AllCarListState();
}

class _AllCarListState extends State<AllCarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Available Cars',
        ),
        // appBar: AppBar(
        //   title: const Text(
        //     'Available Cars',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 22,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   iconTheme: const IconThemeData(color: Colors.white),
        // ),
        backgroundColor: Color.fromARGB(115, 50, 49, 49),
        bottomNavigationBar: buildCustomBottomAppBar(
          context: context,
          showSearch: true,
          onSearchTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarSearchFilterScreen(),
              ),
            );
          },
        ),
        // bottomNavigationBar: BottomAppBar(
        //   height: 70,
        //   color: Color.fromARGB(115, 50, 49, 49),
        //   shape: const CircularNotchedRectangle(),
        //   child: Row(
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => HomeScreen(),
        //               ));
        //         },
        //         child: Container(
        //           height: 28,
        //           width: 28,
        //           child: Image.asset(
        //             'lib/icons/house.png',
        //             color: Color.fromARGB(255, 147, 247, 150),
        //           ),
        //         ),
        //       ),
        //       const Spacer(),
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => (CarSearchFilterScreen()),
        //               ));
        //         },
        //         child: Container(
        //           height: 28,
        //           width: 28,
        //           child: Image.asset(
        //             'lib/icons/search.png',
        //             color: Color.fromARGB(255, 147, 247, 150),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        body: ValueListenableBuilder<Box<CarsModel>>(
            valueListenable: Boxes.getData().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<CarsModel>();
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'No Cars Available',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  cardetails(modelcar: data[index]),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          color: Color.fromARGB(115, 110, 105, 105),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(data[index].selectedImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  data[index].brand,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
