import 'dart:io';
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
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    carsList = Hive.box<CarsModel>('cars_ca1').values.toList();
    filteredCarsList = List.from(carsList);

    _generatePriceOptions();
    _extractBrandAndModelNames();
  }

  void _generatePriceOptions() {
    priceOptions.clear();
    if (carsList.isNotEmpty) {
      int minCarPrice = carsList
          .map((car) => int.parse(car.amount))
          .reduce((a, b) => a < b ? a : b);
      int maxCarPrice = carsList
          .map((car) => int.parse(car.amount))
          .reduce((a, b) => a > b ? a : b);

      for (int i = minCarPrice; i <= maxCarPrice; i += 100) {
        priceOptions.add(i.toString());
      }
      if (!priceOptions.contains(maxCarPrice.toString())) {
        priceOptions.add(maxCarPrice.toString());
      }
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 253, 253),
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(115, 46, 44, 44),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(115, 50, 49, 49),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showFilters) ...[
              TextField(
                controller: searchController,
                onChanged: performSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterDropDown(
                      'Brand',
                      brandNames,
                      selectedBrand,
                      (value) {
                        setState(() {
                          selectedBrand = value == 'None' ? null : value;
                          applyFilters();
                        });
                      },
                    ),
                    SizedBox(width: 30.0),
                    _buildFilterDropDown(
                      'Model',
                      modelNames,
                      selectedModel,
                      (value) {
                        setState(() {
                          selectedModel = value == 'None' ? null : value;
                          applyFilters();
                        });
                      },
                    ),
                    SizedBox(width: 30.0),
                    _buildFilterDropDown(
                      'Year',
                      [
                        '2024',
                        '2023',
                        '2022',
                        '2021',
                        '2020',
                        '2019',
                        '2018',
                        '2017',
                        '2016',
                        '2015',
                      ],
                      selectedYear,
                      (value) {
                        setState(() {
                          selectedYear = value == 'None' ? null : value;
                          applyFilters();
                        });
                      },
                    ),
                    SizedBox(width: 30.0),
                    _buildFilterDropDown(
                      'Seat',
                      ['2', '5', '7', '10'],
                      selectedSeat,
                      (value) {
                        setState(() {
                          selectedSeat = value == 'None' ? null : value;
                          applyFilters();
                        });
                      },
                    ),
                    SizedBox(width: 30.0),
                    _buildFilterDropDown(
                      'Fuel',
                      ['Petrol', 'Diesel'],
                      selectedFuel,
                      (value) {
                        setState(() {
                          selectedFuel = value == 'None' ? null : value;
                          applyFilters();
                        });
                      },
                    ),
                    SizedBox(width: 30.0),
                    _buildPriceDropDown('Min Price', minPrice, priceOptions,
                        (value) {
                      setState(() {
                        minPrice = value == 'None' ? null : value;
                        applyFilters();
                      });
                    }),
                    SizedBox(width: 30.0),
                    _buildPriceDropDown('Max Price', maxPrice, priceOptions,
                        (value) {
                      setState(() {
                        maxPrice = value == 'None' ? null : value;
                        applyFilters();
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
            Text(
              'Filtered Cars: ${filteredCarsList.length}',
              style: TextStyle(color: Colors.yellow),
            ),
            SizedBox(height: 16.0),
            if (filteredCarsList.isEmpty)
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  alignment: Alignment.center,
                  child: Text(
                    'No cars available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredCarsList.length,
                itemBuilder: (context, index) {
                  final car = filteredCarsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarSelect(car: car),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(car.selectedImage)),
                        radius: 25,
                      ),
                      title: Text(car.brand,
                          style: TextStyle(
                            color: Color.fromARGB(255, 253, 255, 253),
                          )),
                      subtitle: Text(
                        car.model,
                        style: TextStyle(
                            color: Color.fromARGB(255, 252, 252, 252)),
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

  Widget _buildFilterDropDown(
    String label,
    List<String> items,
    String? selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        DropdownButton<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: [
            DropdownMenuItem<String>(
              value: 'None',
              child: Text('None'),
            ),
            ...items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ],
          dropdownColor: Color.fromARGB(182, 46, 44, 44),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPriceDropDown(
    String label,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        DropdownButton<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: [
            DropdownMenuItem<String>(
              value: 'None',
              child: Text('None'),
            ),
            ...items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ],
          dropdownColor: Color.fromARGB(115, 46, 44, 44),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
