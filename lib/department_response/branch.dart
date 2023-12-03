import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_name')
  dynamic branchName;
  @JsonKey(name: 'branch_create_date')
  dynamic branchCreateDate;
  @JsonKey(name: 'branch_update_date')
  dynamic branchUpdateDate;

  Branch({
    this.branchId,
    this.branchName,
    this.branchCreateDate,
    this.branchUpdateDate,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return _$BranchFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
