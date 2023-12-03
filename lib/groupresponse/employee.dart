import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  @JsonKey(name: 'employee_id')
  int? employeeId;
  @JsonKey(name: 'employee_create_date')
  DateTime? employeeCreateDate;
  @JsonKey(name: 'employee_update_date')
  dynamic employeeUpdateDate;

  Employee({
    this.employeeId,
    this.employeeCreateDate,
    this.employeeUpdateDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return _$EmployeeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
