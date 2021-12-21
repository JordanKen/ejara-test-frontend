// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tezosModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TezosModelAdapter extends TypeAdapter<TezosModel> {
  @override
  final int typeId = 0;

  @override
  TezosModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TezosModel(
      cycle: fields[0] as double?,
      level: fields[1] as int?,
      hash: fields[2] as String?,
      timestamp: fields[3] as DateTime?,
      proto: fields[4] as double?,
      priority: fields[5] as int?,
      validations: fields[6] as int?,
      deposit: fields[7] as int?,
      reward: fields[8] as int?,
      fees: fields[9] as int?,
      nonceRevealed: fields[10] as bool?,
      lbEscapeVote: fields[11] as bool?,
      lbEscapeEma: fields[12] as int?,
      baker: (fields[13] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TezosModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.cycle)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.hash)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.proto)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.validations)
      ..writeByte(7)
      ..write(obj.deposit)
      ..writeByte(8)
      ..write(obj.reward)
      ..writeByte(9)
      ..write(obj.fees)
      ..writeByte(10)
      ..write(obj.nonceRevealed)
      ..writeByte(11)
      ..write(obj.lbEscapeVote)
      ..writeByte(12)
      ..write(obj.lbEscapeEma)
      ..writeByte(13)
      ..write(obj.baker);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TezosModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TezosModel _$TezosModelFromJson(Map<String, dynamic> json) {
  return TezosModel(
    cycle: (json['cycle'] as num?)?.toDouble(),
    level: json['level'] as int?,
    hash: json['hash'] as String?,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    proto: (json['proto'] as num?)?.toDouble(),
    priority: json['priority'] as int?,
    validations: json['validations'] as int?,
    deposit: json['deposit'] as int?,
    reward: json['reward'] as int?,
    fees: json['fees'] as int?,
    nonceRevealed: json['nonceRevealed'] as bool?,
    lbEscapeVote: json['lbEscapeVote'] as bool?,
    lbEscapeEma: json['lbEscapeEma'] as int?,
    baker: json['baker'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$TezosModelToJson(TezosModel instance) =>
    <String, dynamic>{
      'cycle': instance.cycle,
      'level': instance.level,
      'hash': instance.hash,
      'timestamp': instance.timestamp?.toIso8601String(),
      'proto': instance.proto,
      'priority': instance.priority,
      'validations': instance.validations,
      'deposit': instance.deposit,
      'reward': instance.reward,
      'fees': instance.fees,
      'nonceRevealed': instance.nonceRevealed,
      'lbEscapeVote': instance.lbEscapeVote,
      'lbEscapeEma': instance.lbEscapeEma,
      'baker': instance.baker,
    };
