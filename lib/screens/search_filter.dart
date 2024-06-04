// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_project_final/screens/car_select.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:flutter_project_final/models/carsmodel.dart';

// // class CarSearchFilterScreen extends StatefulWidget {
// //   const CarSearchFilterScreen({Key? key}) : super(key: key);

// //   @override
// //   _CarSearchFilterScreenState createState() => _CarSearchFilterScreenState();
// // }

// // class _CarSearchFilterScreenState extends State<CarSearchFilterScreen> {
// //   late List<CarsModel> carsList;
// //   late List<CarsModel> filteredCarsList;
// //   String? selectedBrand;
// //   String? selectedModel;
// //   String? selectedYear;
// //   String? selectedSeat;
// //   String? selectedFuel;
// //   String? minPrice;
// //   String? maxPrice;
// //   TextEditingController searchController = TextEditingController();
// //   List<String> priceOptions = [];
// //   List<String> brandNames = [];
// //   List<String> modelNames = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     carsList = Hive.box<CarsModel>('car_db').values.toList();
// //     filteredCarsList = List.from(carsList);

// //     _generatePriceOptions();
// //     _extractBrandAndModelNames();
// //   }

// //   void _generatePriceOptions() {
// //     priceOptions.clear();

// //     int minCarPrice = carsList
// //         .map((car) => int.parse(car.amount))
// //         .reduce((a, b) => a < b ? a : b);
// //     int maxCarPrice = carsList
// //         .map((car) => int.parse(car.amount))
// //         .reduce((a, b) => a > b ? a : b);

// //     for (int i = minCarPrice; i <= maxCarPrice; i += 1000) {
// //       priceOptions.add(i.toString());
// //     }
// //     if (!priceOptions.contains(maxCarPrice.toString())) {
// //       priceOptions.add(maxCarPrice.toString());
// //     }
// //   }

// //   void _extractBrandAndModelNames() {
// //     Set<String> uniqueBrands = carsList.map((car) => car.brand).toSet();
// //     brandNames = List<String>.from(uniqueBrands);

// //     Set<String> uniqueModels = carsList.map((car) => car.model).toSet();
// //     modelNames = List<String>.from(uniqueModels);
// //   }

// //   void applyFilters() {
// //     filteredCarsList = carsList.where((car) {
// //       bool brandMatch = selectedBrand == null || car.brand == selectedBrand;
// //       bool modelMatch = selectedModel == null || car.model == selectedModel;
// //       bool yearMatch = selectedYear == null || car.year == selectedYear;
// //       bool seatMatch = selectedSeat == null || car.seat == selectedSeat;
// //       bool fuelMatch = selectedFuel == null || car.fuel == selectedFuel;
// //       bool minPriceMatch = minPrice == null ||
// //           minPrice == 'None' ||
// //           int.parse(car.amount) >= int.parse(minPrice!);
// //       bool maxPriceMatch = maxPrice == null ||
// //           maxPrice == 'None' ||
// //           int.parse(car.amount) <= int.parse(maxPrice!);

// //       return brandMatch &&
// //           modelMatch &&
// //           yearMatch &&
// //           seatMatch &&
// //           fuelMatch &&
// //           minPriceMatch &&
// //           maxPriceMatch;
// //     }).toList();

// //     setState(() {});
// //   }

// //   void performSearch(String query) {
// //     setState(() {
// //       filteredCarsList = carsList.where((car) {
// //         return car.brand.toLowerCase().contains(query.toLowerCase()) ||
// //             car.model.toLowerCase().contains(query.toLowerCase()) ||
// //             car.year.toLowerCase().contains(query.toLowerCase()) ||
// //             car.amount.toLowerCase().contains(query.toLowerCase());
// //       }).toList();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         foregroundColor: Color.fromARGB(255, 147, 247, 150),
// //         backgroundColor: Color.fromARGB(115, 46, 44, 44),
// //         title: Text(
// //           'Search',
// //           style: TextStyle(color: const Color.fromARGB(255, 212, 212, 203)),
// //         ),
// //       ),
// //       backgroundColor: Color.fromARGB(115, 50, 49, 49),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             TextField(
// //               controller: searchController,
// //               onChanged: performSearch,
// //               decoration: InputDecoration(
// //                 hintText: 'Search',
// //                 hintStyle: TextStyle(color: Colors.grey),
// //                 labelText: 'Search',
// //                 labelStyle: TextStyle(
// //                   color: Color.fromARGB(255, 147, 247, 150),
// //                 ),
// //                 prefixIcon: Icon(
// //                   Icons.search,
// //                   color: Color.fromARGB(255, 147, 247, 150),
// //                 ),
// //                 border: OutlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.white),
// //                   borderRadius: BorderRadius.circular(12.0),
// //                 ),
// //               ),
// //               style: TextStyle(color: Colors.white),
// //             ),
// //             SizedBox(height: 16.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 DropdownButton<String>(
// //                   dropdownColor: Colors.black,
// //                   style: TextStyle(color: Colors.white),
// //                   value: selectedBrand,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedBrand = value == 'None' ? null : value;
// //                       applyFilters();
// //                     });
// //                   },
// //                   items: _buildDropdownItems(brandNames),
// //                   hint: Text(
// //                     'Brand',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //                 SizedBox(width: 20.0),
// //                 DropdownButton<String>(
// //                   style: TextStyle(color: Colors.white),
// //                   dropdownColor: Colors.black,
// //                   value: selectedModel,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedModel = value == 'None' ? null : value;
// //                       applyFilters();
// //                     });
// //                   },
// //                   items: _buildDropdownItems(modelNames),
// //                   hint: Text(
// //                     'Model',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //                 SizedBox(width: 20.0),
// //                 DropdownButton<String>(
// //                   style: TextStyle(color: Colors.white),
// //                   dropdownColor: Colors.black,
// //                   value: selectedYear,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedYear = value == 'None' ? null : value;
// //                       applyFilters();
// //                     });
// //                   },
// //                   items: _buildDropdownItems([
// //                     '2015',
// //                     '2016',
// //                     '2017',
// //                     '2018',
// //                     '2019',
// //                     '2020',
// //                     '2021',
// //                     '2022',
// //                     '2023',
// //                     '2005',
// //                     '2007',
// //                   ]),
// //                   hint: Text(
// //                     'Year',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 16.0),
// //             Row(
// //               children: [
// //                 SizedBox(width: 20),
// //                 DropdownButton<String>(
// //                   style: TextStyle(color: Colors.white),
// //                   dropdownColor: Colors.black,
// //                   value: selectedSeat,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedSeat = value == 'None' ? null : value;
// //                       applyFilters();
// //                     });
// //                   },
// //                   items: _buildDropdownItems([
// //                     '2',
// //                     '5',
// //                     '7',
// //                     '10',
// //                   ]),
// //                   hint: Text(
// //                     'Seat',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //                 SizedBox(width: 90),
// //                 DropdownButton<String>(
// //                   style: TextStyle(color: Colors.white),
// //                   dropdownColor: Colors.black,
// //                   value: selectedFuel,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       selectedFuel = value == 'None' ? null : value;
// //                       applyFilters();
// //                     });
// //                   },
// //                   items: _buildDropdownItems([
// //                     'Petrol',
// //                     'Diesel',
// //                   ]),
// //                   hint: Text(
// //                     'Fuel',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 16.0),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 20),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   DropdownButton<String>(
// //                     style: TextStyle(color: Colors.white),
// //                     dropdownColor: Colors.black,
// //                     value: minPrice,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         minPrice = value == 'None' ? null : value;
// //                         applyFilters();
// //                       });
// //                     },
// //                     items: _buildPriceDropdownItems(priceOptions),
// //                     hint: Text(
// //                       'Min Price',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 60,
// //                   ),
// //                   DropdownButton<String>(
// //                     style: TextStyle(color: Colors.white),
// //                     dropdownColor: Colors.black,
// //                     value: maxPrice,
// //                     onChanged: (value) {
// //                       setState(() {
// //                         maxPrice = value == 'None' ? null : value;
// //                         applyFilters();
// //                       });
// //                     },
// //                     items: _buildPriceDropdownItems(priceOptions),
// //                     hint: Text(
// //                       'Max Price',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             SizedBox(height: 16.0),
// //             Text(
// //               'Filtered Cars: ${filteredCarsList.length}',
// //               style: TextStyle(color: Colors.yellow),
// //             ),
// //             SizedBox(height: 16.0),
// //             ListView.builder(
// //               shrinkWrap: true,
// //               itemCount: filteredCarsList.length,
// //               itemBuilder: (context, index) {
// //                 final car = filteredCarsList[index];
// //                 return GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => CarSelect(car: car),
// //                       ),
// //                     );
// //                   },
// //                   child: ListTile(
// //                     leading: CircleAvatar(
// //                       backgroundImage: FileImage(File(car.selectedImage)),
// //                       radius: 25,
// //                     ),
// //                     title: Text(car.brand,
// //                         style: TextStyle(
// //                           color: Color.fromARGB(255, 253, 255, 253),
// //                         )),
// //                     subtitle: Text(
// //                       car.model,
// //                       style:
// //                           TextStyle(color: Color.fromARGB(255, 252, 252, 252)),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
// //     List<DropdownMenuItem<String>> dropdownItems = [];

// //     dropdownItems.add(
// //       DropdownMenuItem<String>(
// //         value: 'None',
// //         child: Text('None'),
// //       ),
// //     );

// //     dropdownItems.addAll(
// //       items.map((item) {
// //         return DropdownMenuItem<String>(
// //           value: item,
// //           child: Text(item),
// //         );
// //       }),
// //     );

// //     return dropdownItems;
// //   }

// //   List<DropdownMenuItem<String>> _buildPriceDropdownItems(List<String> prices) {
// //     List<DropdownMenuItem<String>> dropdownItems = [];

// //     dropdownItems.add(
// //       DropdownMenuItem<String>(
// //         value: 'None',
// //         child: Text('None'),
// //       ),
// //     );

// //     dropdownItems.addAll(
// //       prices.map((price) {
// //         return DropdownMenuItem<String>(
// //           value: price,
// //           child: Text(price),
// //         );
// //       }).toList(),
// //     );

// //     return dropdownItems;
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_final/screens/car_select.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_project_final/models/carsmodel.dart';

// class CarSearchFilterScreen extends StatefulWidget {
//   const CarSearchFilterScreen({Key? key}) : super(key: key);

//   @override
//   _CarSearchFilterScreenState createState() => _CarSearchFilterScreenState();
// }

// class _CarSearchFilterScreenState extends State<CarSearchFilterScreen> {
//   late List<CarsModel> carsList;
//   late List<CarsModel> filteredCarsList;
//   String? selectedBrand;
//   String? selectedModel;
//   String? selectedYear;
//   String? selectedSeat;
//   String? selectedFuel;
//   String? minPrice;
//   String? maxPrice;
//   TextEditingController searchController = TextEditingController();
//   List<String> priceOptions = [];
//   List<String> brandNames = [];
//   List<String> modelNames = [];

//   @override
//   void initState() {
//     super.initState();

//     var box = Hive.box<CarsModel>('cars_ca');
//     carsList = box.values.toList();
//     filteredCarsList = List.from(carsList);
//     _generatePriceOptions();
//     _extractBrandAndModelNames();
//   }

//   void _generatePriceOptions() {
//     priceOptions.clear();

//     int minCarPrice = carsList
//         .map((car) => int.parse(car.amount))
//         .reduce((a, b) => a < b ? a : b);
//     int maxCarPrice = carsList
//         .map((car) => int.parse(car.amount))
//         .reduce((a, b) => a > b ? a : b);

//     for (int i = minCarPrice; i <= maxCarPrice; i += 1000) {
//       priceOptions.add(i.toString());
//     }
//     if (!priceOptions.contains(maxCarPrice.toString())) {
//       priceOptions.add(maxCarPrice.toString());
//     }
//   }

//   void _extractBrandAndModelNames() {
//     Set<String> uniqueBrands = carsList.map((car) => car.brand).toSet();
//     brandNames = List<String>.from(uniqueBrands);

//     Set<String> uniqueModels = carsList.map((car) => car.model).toSet();
//     modelNames = List<String>.from(uniqueModels);
//   }

//   void applyFilters() {
//     filteredCarsList = carsList.where((car) {
//       bool brandMatch = selectedBrand == null || car.brand == selectedBrand;
//       bool modelMatch = selectedModel == null || car.model == selectedModel;
//       bool yearMatch = selectedYear == null || car.year == selectedYear;
//       bool seatMatch = selectedSeat == null || car.seat == selectedSeat;
//       bool fuelMatch = selectedFuel == null || car.fuel == selectedFuel;
//       bool minPriceMatch = minPrice == null ||
//           minPrice == 'None' ||
//           int.parse(car.amount) >= int.parse(minPrice!);
//       bool maxPriceMatch = maxPrice == null ||
//           maxPrice == 'None' ||
//           int.parse(car.amount) <= int.parse(maxPrice!);

//       return brandMatch &&
//           modelMatch &&
//           yearMatch &&
//           seatMatch &&
//           fuelMatch &&
//           minPriceMatch &&
//           maxPriceMatch;
//     }).toList();

//     setState(() {});
//   }

//   void performSearch(String query) {
//     setState(() {
//       filteredCarsList = carsList.where((car) {
//         return car.brand.toLowerCase().contains(query.toLowerCase()) ||
//             car.model.toLowerCase().contains(query.toLowerCase()) ||
//             car.year.toLowerCase().contains(query.toLowerCase()) ||
//             car.amount.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Color.fromARGB(255, 147, 247, 150),
//         backgroundColor: Color.fromARGB(115, 46, 44, 44),
//         title: Text(
//           'Search',
//           style: TextStyle(color: const Color.fromARGB(255, 212, 212, 203)),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(115, 50, 49, 49),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: searchController,
//               onChanged: performSearch,
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 labelText: 'Search',
//                 labelStyle: TextStyle(
//                   color: Color.fromARGB(255, 147, 247, 150),
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Color.fromARGB(255, 147, 247, 150),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 DropdownButton<String>(
//                   dropdownColor: Colors.black,
//                   style: TextStyle(color: Colors.white),
//                   value: selectedBrand,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedBrand = value == 'None' ? null : value;
//                       applyFilters();
//                     });
//                   },
//                   items: _buildDropdownItems(brandNames),
//                   hint: Text(
//                     'Brand',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 20.0),
//                 DropdownButton<String>(
//                   style: TextStyle(color: Colors.white),
//                   dropdownColor: Colors.black,
//                   value: selectedModel,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedModel = value == 'None' ? null : value;
//                       applyFilters();
//                     });
//                   },
//                   items: _buildDropdownItems(modelNames),
//                   hint: Text(
//                     'Model',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 20.0),
//                 DropdownButton<String>(
//                   style: TextStyle(color: Colors.white),
//                   dropdownColor: Colors.black,
//                   value: selectedYear,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedYear = value == 'None' ? null : value;
//                       applyFilters();
//                     });
//                   },
//                   items: _buildDropdownItems([
//                     '2015',
//                     '2016',
//                     '2017',
//                     '2018',
//                     '2019',
//                     '2020',
//                     '2021',
//                     '2022',
//                     '2023',
//                     '2005',
//                     '2007',
//                   ]),
//                   hint: Text(
//                     'Year',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               children: [
//                 SizedBox(width: 20),
//                 DropdownButton<String>(
//                   style: TextStyle(color: Colors.white),
//                   dropdownColor: Colors.black,
//                   value: selectedSeat,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedSeat = value == 'None' ? null : value;
//                       applyFilters();
//                     });
//                   },
//                   items: _buildDropdownItems([
//                     '2',
//                     '5',
//                     '7',
//                     '10',
//                   ]),
//                   hint: Text(
//                     'Seat',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 90),
//                 DropdownButton<String>(
//                   style: TextStyle(color: Colors.white),
//                   dropdownColor: Colors.black,
//                   value: selectedFuel,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedFuel = value == 'None' ? null : value;
//                       applyFilters();
//                     });
//                   },
//                   items: _buildDropdownItems([
//                     'Petrol',
//                     'Diesel',
//                   ]),
//                   hint: Text(
//                     'Fuel',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   DropdownButton<String>(
//                     style: TextStyle(color: Colors.white),
//                     dropdownColor: Colors.black,
//                     value: minPrice,
//                     onChanged: (value) {
//                       setState(() {
//                         minPrice = value == 'None' ? null : value;
//                         applyFilters();
//                       });
//                     },
//                     items: _buildPriceDropdownItems(priceOptions),
//                     hint: Text(
//                       'Min Price',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 60,
//                   ),
//                   DropdownButton<String>(
//                     style: TextStyle(color: Colors.white),
//                     dropdownColor: Colors.black,
//                     value: maxPrice,
//                     onChanged: (value) {
//                       setState(() {
//                         maxPrice = value == 'None' ? null : value;
//                         applyFilters();
//                       });
//                     },
//                     items: _buildPriceDropdownItems(priceOptions),
//                     hint: Text(
//                       'Max Price',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Filtered Cars: ${filteredCarsList.length}',
//               style: TextStyle(color: Colors.yellow),
//             ),
//             SizedBox(height: 16.0),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: filteredCarsList.length,
//               itemBuilder: (context, index) {
//                 final car = filteredCarsList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CarSelect(car: car),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: FileImage(File(car.selectedImage)),
//                       radius: 25,
//                     ),
//                     title: Text(car.brand,
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 253, 255, 253),
//                         )),
//                     subtitle: Text(
//                       car.model,
//                       style:
//                           TextStyle(color: Color.fromARGB(255, 252, 252, 252)),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
//     List<DropdownMenuItem<String>> dropdownItems = [];

//     dropdownItems.add(
//       DropdownMenuItem<String>(
//         value: 'None',
//         child: Text('None'),
//       ),
//     );

//     dropdownItems.addAll(
//       items.map((item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item),
//         );
//       }),
//     );

//     return dropdownItems;
//   }

//   List<DropdownMenuItem<String>> _buildPriceDropdownItems(List<String> prices) {
//     List<DropdownMenuItem<String>> dropdownItems = [];

//     dropdownItems.add(
//       DropdownMenuItem<String>(
//         value: 'None',
//         child: Text('None'),
//       ),
//     );

//     dropdownItems.addAll(
//       prices.map((price) {
//         return DropdownMenuItem<String>(
//           value: price,
//           child: Text(price),
//         );
//       }).toList(),
//     );

//     return dropdownItems;
//   }
// }

//-*****************************************************************************

// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project_final/screens/car_select.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_project_final/models/carsmodel.dart';

class CarSearchFilterScreen extends StatefulWidget {
  const CarSearchFilterScreen({Key? key}) : super(key: key);

  @override
  _CarSearchFilterScreenState createState() => _CarSearchFilterScreenState();
}

class _CarSearchFilterScreenState extends State<CarSearchFilterScreen> {
  late List<CarsModel> carsList;
  late List<CarsModel> filteredCarsList;
  String? selectedBrand;
  String? selectedModel;
  String? selectedYear;
  String? selectedSeat;
  String? selectedFuel;
  String? minPrice;
  String? maxPrice;
  TextEditingController searchController = TextEditingController();
  List<String> priceOptions = [];
  List<String> brandNames = [];
  List<String> modelNames = [];
  bool _showFilters = false; // Added boolean flag

  @override
  void initState() {
    super.initState();
    carsList = Hive.box<CarsModel>('car_db').values.toList();
    filteredCarsList = List.from(carsList);
    _generatePriceOptions();
    _extractBrandAndModelNames();
  }

  void _generatePriceOptions() {
    priceOptions.clear();

    int minCarPrice = carsList
        .map((car) => int.parse(car.amount))
        .reduce((a, b) => a < b ? a : b);
    int maxCarPrice = carsList
        .map((car) => int.parse(car.amount))
        .reduce((a, b) => a > b ? a : b);

    for (int i = minCarPrice; i <= maxCarPrice; i += 1000) {
      priceOptions.add(i.toString());
    }
    if (!priceOptions.contains(maxCarPrice.toString())) {
      priceOptions.add(maxCarPrice.toString());
    }
  }

  void _extractBrandAndModelNames() {
    Set<String> uniqueBrands = carsList.map((car) => car.brand).toSet();
    brandNames = List<String>.from(uniqueBrands);

    Set<String> uniqueModels = carsList.map((car) => car.model).toSet();
    modelNames = List<String>.from(uniqueModels);
  }

  void applyFilters() {
    filteredCarsList = carsList.where((car) {
      bool brandMatch = selectedBrand == null || car.brand == selectedBrand;
      bool modelMatch = selectedModel == null || car.model == selectedModel;
      bool yearMatch = selectedYear == null || car.year == selectedYear;
      bool seatMatch = selectedSeat == null || car.seat == selectedSeat;
      bool fuelMatch = selectedFuel == null || car.fuel == selectedFuel;
      bool minPriceMatch = minPrice == null ||
          minPrice == 'None' ||
          int.parse(car.amount) >= int.parse(minPrice!);
      bool maxPriceMatch = maxPrice == null ||
          maxPrice == 'None' ||
          int.parse(car.amount) <= int.parse(maxPrice!);

      return brandMatch &&
          modelMatch &&
          yearMatch &&
          seatMatch &&
          fuelMatch &&
          minPriceMatch &&
          maxPriceMatch;
    }).toList();

    setState(() {});
  }

  void performSearch(String query) {
    setState(() {
      filteredCarsList = carsList.where((car) {
        return car.brand.toLowerCase().contains(query.toLowerCase()) ||
            car.model.toLowerCase().contains(query.toLowerCase()) ||
            car.year.toLowerCase().contains(query.toLowerCase()) ||
            car.amount.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 147, 247, 150),
        backgroundColor: Color.fromARGB(115, 46, 44, 44),
        title: Text(
          'Search',
          style: TextStyle(color: const Color.fromARGB(255, 212, 212, 203)),
        ),
      ),
      backgroundColor: Color.fromARGB(115, 50, 49, 49),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              onChanged: performSearch,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 147, 247, 150),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 147, 247, 150),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showFilters = !_showFilters; // Toggle filter visibility
                });
              },
              child: Text(_showFilters ? 'Hide Filters' : 'Show Filters'),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: _showFilters,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        value: selectedBrand,
                        onChanged: (value) {
                          setState(() {
                            selectedBrand = value == 'None' ? null : value;
                            applyFilters();
                          });
                        },
                        items: _buildDropdownItems(brandNames),
                        hint: Text(
                          'Brand',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        value: selectedModel,
                        onChanged: (value) {
                          setState(() {
                            selectedModel = value == 'None' ? null : value;
                            applyFilters();
                          });
                        },
                        items: _buildDropdownItems(modelNames),
                        hint: Text(
                          'Model',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        value: selectedYear,
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value == 'None' ? null : value;
                            applyFilters();
                          });
                        },
                        items: _buildDropdownItems([
                          '2015',
                          '2016',
                          '2017',
                          '2018',
                          '2019',
                          '2020',
                          '2021',
                          '2022',
                          '2023',
                          '2005',
                          '2007',
                        ]),
                        hint: Text(
                          'Year',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        value: selectedSeat,
                        onChanged: (value) {
                          setState(() {
                            selectedSeat = value == 'None' ? null : value;
                            applyFilters();
                          });
                        },
                        items: _buildDropdownItems([
                          '2',
                          '5',
                          '7',
                          '10',
                        ]),
                        hint: Text(
                          'Seat',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 90),
                      DropdownButton<String>(
                        style: TextStyle(color: Colors.white),
                        dropdownColor: Colors.black,
                        value: selectedFuel,
                        onChanged: (value) {
                          setState(() {
                            selectedFuel = value == 'None' ? null : value;
                            applyFilters();
                          });
                        },
                        items: _buildDropdownItems([
                          'Petrol',
                          'Diesel',
                        ]),
                        hint: Text(
                          'Fuel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          style: TextStyle(color: Colors.white),
                          dropdownColor: Colors.black,
                          value: minPrice,
                          onChanged: (value) {
                            setState(() {
                              minPrice = value == 'None' ? null : value;
                              applyFilters();
                            });
                          },
                          items: _buildDropdownItems(priceOptions),
                          hint: Text(
                            'Min Price',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 90),
                        DropdownButton<String>(
                          style: TextStyle(color: Colors.white),
                          dropdownColor: Colors.black,
                          value: maxPrice,
                          onChanged: (value) {
                            setState(() {
                              maxPrice = value == 'None' ? null : value;
                              applyFilters();
                            });
                          },
                          items: _buildDropdownItems(priceOptions),
                          hint: Text(
                            'Max Price',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredCarsList.length,
              itemBuilder: (context, index) {
                CarsModel car = filteredCarsList[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarSelect(car: car),
                        ),
                      );
                    },
                    // leading: car.selectedImage !=
                    //     ? Image.file(
                    //         File(car.selectedImage),
                    //         width: 50,
                    //         height: 50,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : Icon(Icons.car_rental),
                    title: Text(car.brand),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Model: ${car.model}'),
                        Text('Year: ${car.year}'),
                        Text('Price: \$${car.amount}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
    return [
      DropdownMenuItem<String>(
        value: 'None',
        child: Text(
          'None',
          style: TextStyle(color: Colors.white),
        ),
      ),
      ...items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    ];
  }
}
