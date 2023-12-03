// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      branchId: json['branch_id'] as int?,
      branchName: json['branch_name'],
      branchCreateDate: json['branch_create_date'],
      branchUpdateDate: json['branch_update_date'],
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'branch_create_date': instance.branchCreateDate,
      'branch_update_date': instance.branchUpdateDate,
    };
