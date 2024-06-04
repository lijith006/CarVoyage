// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carsmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarsModelAdapter extends TypeAdapter<CarsModel> {
  @override
  final int typeId = 0;

  @override
  CarsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarsModel(
      id: fields[0] as int?,
      selectedImage: fields[8] as String,
      model: fields[1] as String,
      year: fields[2] as String,
      insurance: fields[3] as String,
      amount: fields[4] as String,
      seat: fields[5] as String,
      fuel: fields[6] as String,
      brand: fields[7] as String,
      pollutionCertImage: fields[9] as String,
      InsuranceCertImage: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CarsModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.model)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.insurance)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.seat)
      ..writeByte(6)
      ..write(obj.fuel)
      ..writeByte(7)
      ..write(obj.brand)
      ..writeByte(8)
      ..write(obj.selectedImage)
      ..writeByte(9)
      ..write(obj.pollutionCertImage)
      ..writeByte(10)
      ..write(obj.InsuranceCertImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 3;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      id: fields[0] as int?,
      customerName: fields[2] as String,
      contactNumber: fields[3] as String,
      licenseNumber: fields[4] as String,
      pickUpDate: fields[5] as String,
      dropOffDate: fields[6] as String,
      licenseImage: fields[7] as String,
      carFuel: fields[9] as String,
      carSeat: fields[10] as String,
      carBrand: fields[1] as String,
      carModel: fields[8] as String,
      carMonthlyRent: fields[11] as String,
      carImage: fields[12] as String,
      kilometers: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.carBrand)
      ..writeByte(2)
      ..write(obj.customerName)
      ..writeByte(3)
      ..write(obj.contactNumber)
      ..writeByte(4)
      ..write(obj.licenseNumber)
      ..writeByte(5)
      ..write(obj.pickUpDate)
      ..writeByte(6)
      ..write(obj.dropOffDate)
      ..writeByte(7)
      ..write(obj.licenseImage)
      ..writeByte(8)
      ..write(obj.carModel)
      ..writeByte(9)
      ..write(obj.carFuel)
      ..writeByte(10)
      ..write(obj.carSeat)
      ..writeByte(11)
      ..write(obj.carMonthlyRent)
      ..writeByte(12)
      ..write(obj.carImage)
      ..writeByte(13)
      ..write(obj.kilometers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
