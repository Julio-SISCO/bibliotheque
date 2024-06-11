// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livre.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LivreAdapter extends TypeAdapter<Livre> {
  @override
  final int typeId = 0;

  @override
  Livre read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Livre(
      titre: fields[0] as String,
      auteur: fields[1] as String?,
      annee: fields[3] as String?,
      editeur: fields[4] as String?,
      favori: fields[2] as bool,
      commentaires: (fields[5] as List?)?.cast<String>(),
      notes: (fields[6] as List?)?.cast<String>(),
      couverture: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Livre obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.titre)
      ..writeByte(1)
      ..write(obj.auteur)
      ..writeByte(2)
      ..write(obj.favori)
      ..writeByte(3)
      ..write(obj.annee)
      ..writeByte(4)
      ..write(obj.editeur)
      ..writeByte(5)
      ..write(obj.commentaires)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.couverture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LivreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
