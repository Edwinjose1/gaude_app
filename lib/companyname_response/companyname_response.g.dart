// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companyname_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanynameResponse _$CompanynameResponseFromJson(Map<String, dynamic> json) =>
    CompanynameResponse(
      id: json['id'] as int?,
      companyName: json['company_name'] as String?,
      companynameCreatedDate: json['companyname_created_date'],
      companynameUpdateDate: json['companyname_update_date'],
    );

Map<String, dynamic> _$CompanynameResponseToJson(
        CompanynameResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_name': instance.companyName,
      'companyname_created_date': instance.companynameCreatedDate,
      'companyname_update_date': instance.companynameUpdateDate,
    };
