import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final int number;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String? image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.number,
      required this.address,
      this.image, required key});

  toJson() {}

  toMap() {}
}