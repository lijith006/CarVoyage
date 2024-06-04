import 'package:hive_flutter/adapters.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String password;
  @HiveField(3)
  late String phone;
  @HiveField(4)
  late int status;
  @HiveField(5)
  late String id;
  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.status,
      required this.id});
}
