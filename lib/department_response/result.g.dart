// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      departmentId: json['department_id'] as int?,
      departmentName: json['department_name'] as String?,
      departmentCreateDate: json['department_create_date'] == null
          ? null
          : DateTime.parse(json['department_create_date'] as String),
      departmentUpdateDate: json['department_update_date'],
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'department_create_date':
          instance.departmentCreateDate?.toIso8601String(),
      'department_update_date': instance.departmentUpdateDate,
      'branches': instance.branches,
    };
