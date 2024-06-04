import 'package:flutter_project_final/models/carsmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<CarsModel> getData() => Hive.box<CarsModel>('cars_ca');
  static Box<CustomerModel> getCustomerData() =>
      Hive.box<CustomerModel>('customer_cu');
  static Box<CarsModel> BrandData() => Hive.box<CarsModel>('brands');
}
