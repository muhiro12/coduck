// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final typeId = 0;

  @override
  Item read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item()
      ..updatedAt = fields[0] as DateTime
      ..title = fields[1] as String
      ..data = fields[2] as String
      ..note = fields[3] as String
      ..type = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.updatedAt)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.type);
  }
}
