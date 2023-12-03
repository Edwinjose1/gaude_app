import 'package:json_annotation/json_annotation.dart';

part 'departmente.g.dart';

@JsonSerializable()
class Departmente {
  @JsonKey(name: 'department_id')
  int? departmentId;
  @JsonKey(name: 'department_name')
  dynamic departmentName;
  @JsonKey(name: 'department_create_date')
  dynamic departmentCreateDate;
  @JsonKey(name: 'department_update_date')
  dynamic departmentUpdateDate;

  Departmente({
    this.departmentId,
    this.departmentName,
    this.departmentCreateDate,
    this.departmentUpdateDate,
  });

  factory Departmente.fromJson(Map<String, dynamic> json) {
    return _$DepartmenteFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmenteToJson(this);
}
