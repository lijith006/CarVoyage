import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CarsModel>> carListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);

Future<void> addCar(CarsModel value) async {
  final carDB = await Hive.openBox<CarsModel>('cars_ca');
  final id = await carDB.add(value);
  value.id = id;
  carListNotifier.value.add(value);

  // carListNotifier.notifyListeners();
}

//************************
Future<void> getCars() async {
  final carDB = await Hive.openBox<CarsModel>('cars_ca');
  carListNotifier.value.clear();
  carListNotifier.value.addAll(carDB.values);
  // carListNotifier.notifyListeners();
}

Future<void> deletecar(CarsModel car) async {
  await car.delete();
  getCars();
}

List<CarsModel> searchCars(String query) {
  final carDB = Hive.box<CarsModel>('cars_ca');
  final List<CarsModel> allCars = carDB.values.toList();

  if (query.isEmpty) {
    return allCars;
  }

  final List<CarsModel> searchResults = allCars
      .where((car) => car.model.toLowerCase().contains(query.toLowerCase()))
      .toList();

  return searchResults;
}

List<CarsModel> removedCarList = [];
void removedCar(CarsModel car) {
  removedCarList.add(car);
  carListNotifier.value.remove(car);
  Boxes.getData().delete(car.key);
}

List<CarsModel> getRemovedCars() {
  return removedCarList;
}

List<CustomerModel> removedCustomerList = [];
void removeCustomerFromScreen(CustomerModel customer) {
  removedCustomerList.add(customer);
  customerListNotifier.value.remove(customer);
  Boxes.getCustomerData().delete(customer.key);
}

Future<void> CustomerAdd(CustomerModel value) async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_cu');
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
}
