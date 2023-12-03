// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groupresponse _$GroupresponseFromJson(Map<String, dynamic> json) =>
    Groupresponse(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GroupresponseToJson(Groupresponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
      'message': instance.message,
    };
