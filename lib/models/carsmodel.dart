import 'package:hive_flutter/adapters.dart';
part 'carsmodel.g.dart';

@HiveType(typeId: 0)
class CarsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late String model;
  @HiveField(2)
  late String year;
  @HiveField(3)
  late String insurance;
  @HiveField(4)
  late String amount;
  @HiveField(5)
  late String seat;
  @HiveField(6)
  late String fuel;
  @HiveField(7)
  late String brand;
  @HiveField(8)
  late String selectedImage;
  @HiveField(9)
  late String pollutionCertImage;
  @HiveField(10)
  late String InsuranceCertImage;

  CarsModel({
    this.id,
    required this.selectedImage,
    required this.model,
    required this.year,
    required this.insurance,
    required this.amount,
    required this.seat,
    required this.fuel,
    required this.brand,
    required this.pollutionCertImage,
    required this.InsuranceCertImage,
  });
}

@HiveType(typeId: 3)
class CustomerModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late String carBrand;
  @HiveField(2)
  late String customerName;
  @HiveField(3)
  late String contactNumber;
  @HiveField(4)
  late String licenseNumber;
  @HiveField(5)
  late String pickUpDate;
  @HiveField(6)
  late String dropOffDate;
  @HiveField(7)
  late String licenseImage;
  @HiveField(8)
  late String carModel;
  @HiveField(9)
  late String carFuel;
  @HiveField(10)
  late String carSeat;
  @HiveField(11)
  late String carMonthlyRent;
  @HiveField(12)
  late String carImage;
  @HiveField(13)
  late String kilometers;
  CustomerModel({
    this.id,
    required this.customerName,
    required this.contactNumber,
    required this.licenseNumber,
    required this.pickUpDate,
    required this.dropOffDate,
    required this.licenseImage,
    required this.carFuel,
    required this.carSeat,
    required this.carBrand,
    required this.carModel,
    required this.carMonthlyRent,
    required this.carImage,
    required this.kilometers,
  });
}
