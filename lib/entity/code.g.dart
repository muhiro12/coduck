// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CodeAdapter extends TypeAdapter<Code> {
  @override
  final typeId = 0;

  @override
  Code read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Code(
      fields[1] as int,
      fields[2] as String,
    )
      ..updatedAt = fields[0] as DateTime
      ..title = fields[3] as String
      ..note = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Code obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.updatedAt)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.note);
  }
}
