// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentResponse _$DepartmentResponseFromJson(Map<String, dynamic> json) =>
    DepartmentResponse(
      id: json['id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCreateDate: json['department_create_date'] == null
          ? null
          : DateTime.parse(json['department_create_date'] as String),
      departmentUpdateDate: json['department_update_date'],
    );

Map<String, dynamic> _$DepartmentResponseToJson(DepartmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'department_name': instance.departmentName,
      'department_create_date':
          instance.departmentCreateDate?.toIso8601String(),
      'department_update_date': instance.departmentUpdateDate,
    };
