// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      employeeId: json['employee_id'] as int?,
      employeeCreateDate: json['employee_create_date'] == null
          ? null
          : DateTime.parse(json['employee_create_date'] as String),
      employeeUpdateDate: json['employee_update_date'],
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'employee_id': instance.employeeId,
      'employee_create_date': instance.employeeCreateDate?.toIso8601String(),
      'employee_update_date': instance.employeeUpdateDate,
    };
