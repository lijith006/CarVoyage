import 'package:flutter/material.dart';
import 'package:flutter_project_final/db_functions/box.dart';
import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CarsModel>> carListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);

Future<void> addCar(CarsModel value) async {
  print("Adding car: ${value.brand}");
  final carDB = await Hive.openBox<CarsModel>('cars_ca1');
  final id = await carDB.add(value);
  value.id = id;
  carListNotifier.value.add(value);

  carListNotifier.notifyListeners();
  print("Car added.");
}

Future<void> verifyCarAdded() async {
  final carDB = await Hive.openBox<CarsModel>('car_db');
  print("Available cars: ${carDB.values.toList()}");
}

//************************
Future<void> getCars() async {
  final carDB = await Hive.openBox<CarsModel>('cars_ca1');
  carListNotifier.value.clear();
  carListNotifier.value.addAll(carDB.values);
  carListNotifier.notifyListeners();
}

Future<void> getAllCustomers() async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_cu2');
  customerListNotifier.value.clear();
  customerListNotifier.value.addAll(customerDB.values);
  customerListNotifier.notifyListeners();
}

Future<void> deletecar(CarsModel car) async {
  await car.delete();
  getCars();
}

List<CarsModel> searchCars(String query) {
  final carDB = Hive.box<CarsModel>('cars_ca1');
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

void clearRemovedCars() {
  removedCarList.clear();
}

List<CustomerModel> removedCustomerList = [];
void removeCustomerFromScreen(CustomerModel customer) {
  print("Removing customer: ${customer.customerName}");
  removedCustomerList.add(customer);
  customerListNotifier.value.remove(customer);
  Boxes.getCustomerData().delete(customer.key);
  customerListNotifier.notifyListeners();
  print("Customer removed.");
}

List<CustomerModel> getRemovedCustomers() {
  return removedCustomerList;
}

void clearRemovedCustomers() {
  removedCustomerList.clear();
}

Future<void> CustomerAdd(CustomerModel value) async {
  final customerDB = await Hive.openBox<CustomerModel>('customer_cu2');
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
}
