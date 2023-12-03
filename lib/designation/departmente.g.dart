// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departmente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departmente _$DepartmenteFromJson(Map<String, dynamic> json) => Departmente(
      departmentId: json['department_id'] as int?,
      departmentName: json['department_name'],
      departmentCreateDate: json['department_create_date'],
      departmentUpdateDate: json['department_update_date'],
    );

Map<String, dynamic> _$DepartmenteToJson(Departmente instance) =>
    <String, dynamic>{
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'department_create_date': instance.departmentCreateDate,
      'department_update_date': instance.departmentUpdateDate,
    };
