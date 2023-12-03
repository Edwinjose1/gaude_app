// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeResponse _$EmployeeResponseFromJson(Map<String, dynamic> json) =>
    EmployeeResponse(
      id: json['id'] as int?,
      empImage: json['emp_image'] as String?,
      empName: json['emp_name'] as String?,
      empDepartment: json['emp_department'] as String?,
      empDesignation: json['emp_designation'] as String?,
      empId: json['emp_id'] as int?,
      empAddress: json['emp_address'] as String?,
      empEmail: json['emp_email'] as String?,
      empMobile: json['emp_mobile'] as int?,
    );

Map<String, dynamic> _$EmployeeResponseToJson(EmployeeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emp_image': instance.empImage,
      'emp_name': instance.empName,
      'emp_department': instance.empDepartment,
      'emp_designation': instance.empDesignation,
      'emp_id': instance.empId,
      'emp_address': instance.empAddress,
      'emp_email': instance.empEmail,
      'emp_mobile': instance.empMobile,
    };
