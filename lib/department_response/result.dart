import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: 'department_id')
  int? departmentId;
  @JsonKey(name: 'department_name')
  String? departmentName;
  @JsonKey(name: 'department_create_date')
  DateTime? departmentCreateDate;
  @JsonKey(name: 'department_update_date')
  dynamic departmentUpdateDate;
  @JsonKey(name: 'branches')
  List<Map<String, dynamic>>? branches;

  Result({
    this.departmentId,
    this.departmentName,
    this.departmentCreateDate,
    this.departmentUpdateDate,
    this.branches,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
