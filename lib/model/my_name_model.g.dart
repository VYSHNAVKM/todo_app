// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_name_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNameModelAdapter extends TypeAdapter<MyNameModel> {
  @override
  final int typeId = 0;

  @override
  MyNameModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNameModel(
      selectColor: fields[3] as int,
      date: fields[2] as DateTime,
      description: fields[1] as String,
      title: fields[0] as String,
      key: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MyNameModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.selectColor)
      ..writeByte(4)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNameModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
