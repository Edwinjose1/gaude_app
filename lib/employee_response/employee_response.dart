import 'package:json_annotation/json_annotation.dart';

part 'employee_response.g.dart';

@JsonSerializable()
class EmployeeResponse {
  int? id;
  @JsonKey(name: 'emp_image')
  String? empImage;
  @JsonKey(name: 'emp_name')
  String? empName;
  @JsonKey(name: 'emp_department')
  String? empDepartment;
  @JsonKey(name: 'emp_designation')
  String? empDesignation;
  @JsonKey(name: 'emp_id')
  int? empId;
  @JsonKey(name: 'emp_address')
  String? empAddress;
  @JsonKey(name: 'emp_email')
  String? empEmail;
  @JsonKey(name: 'emp_mobile')
  int? empMobile;

  EmployeeResponse({
    this.id,
    this.empImage,
    this.empName,
    this.empDepartment,
    this.empDesignation,
    this.empId,
    this.empAddress,
    this.empEmail,
    this.empMobile,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return _$EmployeeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeResponseToJson(this);
}
