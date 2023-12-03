// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchResponse _$BranchResponseFromJson(Map<String, dynamic> json) =>
    BranchResponse(
      id: json['id'] as int?,
      branchName: json['branch_name'] as String?,
      branchCreateDate: json['branch_create_date'] == null
          ? null
          : DateTime.parse(json['branch_create_date'] as String),
      branchUpdateDate: json['branch_update_date'],
    );

Map<String, dynamic> _$BranchResponseToJson(BranchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branch_name': instance.branchName,
      'branch_create_date': instance.branchCreateDate?.toIso8601String(),
      'branch_update_date': instance.branchUpdateDate,
    };
