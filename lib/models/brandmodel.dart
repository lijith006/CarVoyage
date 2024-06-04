import 'package:hive_flutter/adapters.dart';
part 'brandmodel.g.dart';

@HiveType(typeId: 2)
class BrandModel extends HiveObject {
  @HiveField(1)
  int? id;
  @HiveField(2)
  late String brandNames;
  @HiveField(3)
  late String brandLogoImagePath;
  BrandModel({required this.brandNames, required this.brandLogoImagePath});
}
