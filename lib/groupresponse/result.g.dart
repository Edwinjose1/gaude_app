// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      groupId: json['group_id'] as int?,
      groupName: json['group_name'] as String?,
      groupCreateDate: json['group_create_date'] == null
          ? null
          : DateTime.parse(json['group_create_date'] as String),
      groupUpdateDate: json['group_update_date'],
      employees: (json['employees'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'group_id': instance.groupId,
      'group_name': instance.groupName,
      'group_create_date': instance.groupCreateDate?.toIso8601String(),
      'group_update_date': instance.groupUpdateDate,
      'employees': instance.employees,
    };
