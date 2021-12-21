
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitcoinModel.g.dart';


@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 0)
class BitcoinModel {

  @HiveField(0)
  String? hash;

  @HiveField(1)
  int? ver;

  @HiveField(2)
  int? vin_sz;

  @HiveField(3)
  int? vout_sz;

  @HiveField(4)
  int? size;

  @HiveField(5)
  int? weight;

  @HiveField(6)
  int? fee;

  @HiveField(7)
  String? relayed_by;

  @HiveField(8)
  int? lock_time;

@HiveField(9)
  int? tx_index;

 @HiveField(10)
  bool? double_spend;

  @HiveField(11)
  int? time;

  @HiveField(12)
  int? block_index;

  @HiveField(13)
  int? block_height;

  @HiveField(14)
  List<Map<String,dynamic>>? inputs;


 @HiveField(15)
  List<Map<String,dynamic>>? out;


  BitcoinModel(
      {this.hash,
      this.ver,
      this.vin_sz,
      this.vout_sz,
      this.size,
      this.weight,
      this.fee,
      this.relayed_by,
      this.lock_time,
      this.tx_index,
      this.double_spend,
      this.time,
      this.block_index,
      this.block_height,
      this.inputs,
      this.out});

  factory BitcoinModel.fromJson(Map<String, dynamic> json) => _$BitcoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$BitcoinModelToJson(this);

  @override
  String toString() {
    return 'BitcoinModel{hash: $hash, ver: $ver, vin_sz: $vin_sz, vout_sz: $vout_sz, size: $size, weight: $weight, fee: $fee, relayed_by: $relayed_by, lock_time: $lock_time, tx_index: $tx_index, double_spend: $double_spend, time: $time, block_index: $block_index, block_height: $block_height}';
  }
}
