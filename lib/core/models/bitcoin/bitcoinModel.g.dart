// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitcoinModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BitcoinModelAdapter extends TypeAdapter<BitcoinModel> {
  @override
  final int typeId = 0;

  @override
  BitcoinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BitcoinModel(
      hash: fields[0] as String?,
      ver: fields[1] as int?,
      vin_sz: fields[2] as int?,
      vout_sz: fields[3] as int?,
      size: fields[4] as int?,
      weight: fields[5] as int?,
      fee: fields[6] as int?,
      relayed_by: fields[7] as String?,
      lock_time: fields[8] as int?,
      tx_index: fields[9] as int?,
      double_spend: fields[10] as bool?,
      time: fields[11] as int?,
      block_index: fields[12] as int?,
      block_height: fields[13] as int?,
      inputs: (fields[14] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
      out: (fields[15] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, BitcoinModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.hash)
      ..writeByte(1)
      ..write(obj.ver)
      ..writeByte(2)
      ..write(obj.vin_sz)
      ..writeByte(3)
      ..write(obj.vout_sz)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.fee)
      ..writeByte(7)
      ..write(obj.relayed_by)
      ..writeByte(8)
      ..write(obj.lock_time)
      ..writeByte(9)
      ..write(obj.tx_index)
      ..writeByte(10)
      ..write(obj.double_spend)
      ..writeByte(11)
      ..write(obj.time)
      ..writeByte(12)
      ..write(obj.block_index)
      ..writeByte(13)
      ..write(obj.block_height)
      ..writeByte(14)
      ..write(obj.inputs)
      ..writeByte(15)
      ..write(obj.out);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitcoinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitcoinModel _$BitcoinModelFromJson(Map<String, dynamic> json) {
  return BitcoinModel(
    hash: json['hash'] as String?,
    ver: json['ver'] as int?,
    vin_sz: json['vin_sz'] as int?,
    vout_sz: json['vout_sz'] as int?,
    size: json['size'] as int?,
    weight: json['weight'] as int?,
    fee: json['fee'] as int?,
    relayed_by: json['relayed_by'] as String?,
    lock_time: json['lock_time'] as int?,
    tx_index: json['tx_index'] as int?,
    double_spend: json['double_spend'] as bool?,
    time: json['time'] as int?,
    block_index: json['block_index'] as int?,
    block_height: json['block_height'] as int?,
    inputs: (json['inputs'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    out: (json['out'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$BitcoinModelToJson(BitcoinModel instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'ver': instance.ver,
      'vin_sz': instance.vin_sz,
      'vout_sz': instance.vout_sz,
      'size': instance.size,
      'weight': instance.weight,
      'fee': instance.fee,
      'relayed_by': instance.relayed_by,
      'lock_time': instance.lock_time,
      'tx_index': instance.tx_index,
      'double_spend': instance.double_spend,
      'time': instance.time,
      'block_index': instance.block_index,
      'block_height': instance.block_height,
      'inputs': instance.inputs,
      'out': instance.out,
    };
