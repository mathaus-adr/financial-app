// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atividade.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AtividadeAdapter extends TypeAdapter<Atividade> {
  @override
  final int typeId = 0;

  @override
  Atividade read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Atividade(
      name: fields[0] as String,
      participantes: (fields[1] as List?)?.cast<Participante>(),
      contas: (fields[2] as List?)?.cast<Conta>(),
    );
  }

  @override
  void write(BinaryWriter writer, Atividade obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.participantes)
      ..writeByte(2)
      ..write(obj.contas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AtividadeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
