import 'package:json_annotation/json_annotation.dart';

part 'designation.g.dart';

@JsonSerializable()
class DesignationModel {
  @JsonKey(name: 'designation_id')
  int? designationId;
  @JsonKey(name: 'designation_name')
  String? designationName;
  @JsonKey(name: 'designation_create_date')
  DateTime? designationCreateDate;
  @JsonKey(name: 'designation_update_date')
  dynamic designationUpdateDate;
  @JsonKey(name: 'departmentes')
  List<Map<String, dynamic>>? departmentes;

  DesignationModel({
    this.designationId,
    this.designationName,
    this.designationCreateDate,
    this.designationUpdateDate,
    this.departmentes,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return _$DesignationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DesignationModelToJson(this);
}
