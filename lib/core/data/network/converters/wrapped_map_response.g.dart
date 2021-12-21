// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapped_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrappedMapResponse _$WrappedMapResponseFromJson(Map<String, dynamic> json) {
  return WrappedMapResponse(
    message: json['message'] as String?,
    status: json['status'] as bool?,
    data: json['data'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$WrappedMapResponseToJson(WrappedMapResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };
