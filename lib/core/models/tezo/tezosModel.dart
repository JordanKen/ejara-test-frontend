
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tezosModel.g.dart';


@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 0)
class TezosModel {

  @HiveField(0)
  double? cycle;

  @HiveField(1)
  int? level;

  @HiveField(2)
  String? hash;

  @HiveField(3)
  DateTime? timestamp;

  @HiveField(4)
  double? proto;

  @HiveField(5)
  int? priority;

  @HiveField(6)
  int? validations;

  @HiveField(7)
  int? deposit;

  @HiveField(8)
  int? reward;

  @HiveField(9)
  int? fees;

  @HiveField(10)
  bool? nonceRevealed;

  @HiveField(11)
  bool? lbEscapeVote;

  @HiveField(12)
  int? lbEscapeEma;

  @HiveField(13)
  Map<String,dynamic>? baker;


  TezosModel(
      {this.cycle,
      this.level,
      this.hash,
      this.timestamp,
      this.proto,
      this.priority,
      this.validations,
      this.deposit,
      this.reward,
      this.fees,
      this.nonceRevealed,
      this.lbEscapeVote,
      this.lbEscapeEma,
      this.baker});

  factory TezosModel.fromJson(Map<String, dynamic> json) => _$TezosModelFromJson(json);

  Map<String, dynamic> toJson() => _$TezosModelToJson(this);

  @override
  String toString() {
    return 'TezosModel{cycle: $cycle, level: $level, hash: $hash, timestamp: $timestamp, proto: $proto, priority: $priority, validations: $validations, deposit: $deposit, reward: $reward, fees: $fees, nonceRevealed: $nonceRevealed, lbEscapeVote: $lbEscapeVote, lbEscapeEma: $lbEscapeEma, baker: $baker}';
  }
}
