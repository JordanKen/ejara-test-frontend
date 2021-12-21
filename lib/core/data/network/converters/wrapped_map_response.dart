import 'package:json_annotation/json_annotation.dart';

part 'wrapped_map_response.g.dart';

@JsonSerializable()
class WrappedMapResponse{
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "data")
  Map<String, dynamic>? data;

  WrappedMapResponse({this.message, this.status, this.data});


  factory WrappedMapResponse.fromJson(Map<String, dynamic> json) => _$WrappedMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WrappedMapResponseToJson(this);

}
