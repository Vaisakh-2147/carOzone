
import 'package:hive/hive.dart';

part 'car_comparison.g.dart';

@HiveType(typeId: 1)
class CarComparison extends HiveObject {
  @HiveField(0)
  late String carId;

  @HiveField(1)
  late String imageUrl;

  @HiveField(2)
  late String text;

  @HiveField(3)
  late String prize;

  @HiveField(4)
  late String transmission;

  @HiveField(5)
  late String fueltype;

  @HiveField(6)
  late String enginesize;

  @HiveField(7)
  late String mileage;

  @HiveField(8)
  late String safetyrating;

  @HiveField(9)
  late String groundclearance;

  @HiveField(10)
  late String seatingcapacity;

  @HiveField(11)
  late String carsize;

  @HiveField(12)
  late String carfueltank;

  @HiveField(13)
  late String secondImageUrl;

  @HiveField(14)
  late String secondText;

  @HiveField(15)
  late String secondPrize;

  @HiveField(16)
  late String secondFueltype;

  @HiveField(17)
  late String secondTransmission;

  @HiveField(18)
  late String secondEnginesize;

  @HiveField(19)
  late String secondMileage;

  @HiveField(20)
  late String secondSafetyrating;

  @HiveField(21)
  late String secondGroundclearance;

  @HiveField(22)
  late String secondSeatingcapacity;

  @HiveField(23)
  late String secondCarsize;

  @HiveField(24)
  late String secondCarfueltank;

  CarComparison({
    required this.carId,
    required this.imageUrl,
    required this.text,
    required this.prize,
    required this.transmission,
    required this.fueltype,
    required this.enginesize,
    required this.mileage,
    required this.safetyrating,
    required this.groundclearance,
    required this.seatingcapacity,
    required this.carsize,
    required this.carfueltank,
    required this.secondImageUrl,
    required this.secondText,
    required this.secondPrize,
    required this.secondFueltype,
    required this.secondTransmission,
    required this.secondEnginesize,
    required this.secondMileage,
    required this.secondSafetyrating,
    required this.secondGroundclearance,
    required this.secondSeatingcapacity,
    required this.secondCarfueltank,
    required this.secondCarsize,
  });
}
