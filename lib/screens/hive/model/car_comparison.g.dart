// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_comparison.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarComparisonAdapter extends TypeAdapter<CarComparison> {
  @override
  final int typeId = 1;

  @override
  CarComparison read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarComparison(
      carId: fields[0] as String,
      imageUrl: fields[1] as String,
      text: fields[2] as String,
      prize: fields[3] as String,
      transmission: fields[4] as String,
      fueltype: fields[5] as String,
      enginesize: fields[6] as String,
      mileage: fields[7] as String,
      safetyrating: fields[8] as String,
      groundclearance: fields[9] as String,
      seatingcapacity: fields[10] as String,
      carsize: fields[11] as String,
      carfueltank: fields[12] as String,
      secondImageUrl: fields[13] as String,
      secondText: fields[14] as String,
      secondPrize: fields[15] as String,
      secondFueltype: fields[16] as String,
      secondTransmission: fields[17] as String,
      secondEnginesize: fields[18] as String,
      secondMileage: fields[19] as String,
      secondSafetyrating: fields[20] as String,
      secondGroundclearance: fields[21] as String,
      secondSeatingcapacity: fields[22] as String,
      secondCarfueltank: fields[24] as String,
      secondCarsize: fields[23] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarComparison obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.carId)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.prize)
      ..writeByte(4)
      ..write(obj.transmission)
      ..writeByte(5)
      ..write(obj.fueltype)
      ..writeByte(6)
      ..write(obj.enginesize)
      ..writeByte(7)
      ..write(obj.mileage)
      ..writeByte(8)
      ..write(obj.safetyrating)
      ..writeByte(9)
      ..write(obj.groundclearance)
      ..writeByte(10)
      ..write(obj.seatingcapacity)
      ..writeByte(11)
      ..write(obj.carsize)
      ..writeByte(12)
      ..write(obj.carfueltank)
      ..writeByte(13)
      ..write(obj.secondImageUrl)
      ..writeByte(14)
      ..write(obj.secondText)
      ..writeByte(15)
      ..write(obj.secondPrize)
      ..writeByte(16)
      ..write(obj.secondFueltype)
      ..writeByte(17)
      ..write(obj.secondTransmission)
      ..writeByte(18)
      ..write(obj.secondEnginesize)
      ..writeByte(19)
      ..write(obj.secondMileage)
      ..writeByte(20)
      ..write(obj.secondSafetyrating)
      ..writeByte(21)
      ..write(obj.secondGroundclearance)
      ..writeByte(22)
      ..write(obj.secondSeatingcapacity)
      ..writeByte(23)
      ..write(obj.secondCarsize)
      ..writeByte(24)
      ..write(obj.secondCarfueltank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarComparisonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
