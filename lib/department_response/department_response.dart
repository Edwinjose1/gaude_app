import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'department_response.g.dart';

@JsonSerializable()
class DepartmentResponse {
  int? id;
  @JsonKey(name: 'department_name')
  String? departmentName;
  @JsonKey(name: 'department_create_date')
  DateTime? departmentCreateDate;
  @JsonKey(name: 'department_update_date')
  dynamic departmentUpdateDate;
  DepartmentResponse({
    this.id,
    this.departmentName,
    this.departmentCreateDate,
    this.departmentUpdateDate,
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return _$DepartmentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentResponseToJson(this);
}
