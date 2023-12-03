// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignationModel _$DesignationModelFromJson(Map<String, dynamic> json) =>
    DesignationModel(
      designationId: json['designation_id'] as int?,
      designationName: json['designation_name'] as String?,
      designationCreateDate: json['designation_create_date'] == null
          ? null
          : DateTime.parse(json['designation_create_date'] as String),
      designationUpdateDate: json['designation_update_date'],
      departmentes: (json['departmentes'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$DesignationModelToJson(DesignationModel instance) =>
    <String, dynamic>{
      'designation_id': instance.designationId,
      'designation_name': instance.designationName,
      'designation_create_date':
          instance.designationCreateDate?.toIso8601String(),
      'designation_update_date': instance.designationUpdateDate,
      'departmentes': instance.departmentes,
    };
