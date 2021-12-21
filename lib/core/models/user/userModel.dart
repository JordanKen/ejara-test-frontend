
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';


@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 0)
class UserModel {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? password;

  @HiveField(6)
  String? avatar;

  @HiveField(7)
  bool? statut;

  @HiveField(8)
  DateTime? created_at;

  @HiveField(9)
  DateTime? updated_at;


  UserModel(
      {this.id,
      this.name,
      this.username,
      this.phone,
      this.email,
      this.password,
      this.avatar,
      this.statut,
      this.created_at,
      this.updated_at});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, username: $username, phone: $phone, email: $email, password: $password, avatar: $avatar, statut: $statut, created_at: $created_at, updated_at: $updated_at}';
  }
}
