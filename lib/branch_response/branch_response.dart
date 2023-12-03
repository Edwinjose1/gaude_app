import 'package:json_annotation/json_annotation.dart';

part 'branch_response.g.dart';

@JsonSerializable()
class BranchResponse {
  int? id;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'branch_create_date')
  DateTime? branchCreateDate;
  @JsonKey(name: 'branch_update_date')
  dynamic branchUpdateDate;

  BranchResponse({
    this.id,
    this.branchName,
    this.branchCreateDate,
    this.branchUpdateDate,
  });

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return _$BranchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BranchResponseToJson(this);
}
