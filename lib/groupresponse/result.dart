import 'package:json_annotation/json_annotation.dart';

import 'employee.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: 'group_id')
  int? groupId;
  @JsonKey(name: 'group_name')
  String? groupName;
  @JsonKey(name: 'group_create_date')
  DateTime? groupCreateDate;
  @JsonKey(name: 'group_update_date')
  dynamic groupUpdateDate;
   @JsonKey(name: 'employees')
  List<Map<String, dynamic>>? employees;

  Result({
    this.groupId,
    this.groupName,
    this.groupCreateDate,
    this.groupUpdateDate,
    this.employees,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
