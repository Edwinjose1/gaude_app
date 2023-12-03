// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationResponse _$ClassificationResponseFromJson(
        Map<String, dynamic> json) =>
    ClassificationResponse(
      id: json['id'] as int?,
      classificationName: json['classification_name'] as String?,
      classificatioinCreateDate: json['classificatioin_create_date'] == null
          ? null
          : DateTime.parse(json['classificatioin_create_date'] as String),
      classificationUpdateDate: json['classification_update_date'],
    );

Map<String, dynamic> _$ClassificationResponseToJson(
        ClassificationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classification_name': instance.classificationName,
      'classificatioin_create_date':
          instance.classificatioinCreateDate?.toIso8601String(),
      'classification_update_date': instance.classificationUpdateDate,
    };
