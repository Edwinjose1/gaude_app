// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logoresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logoresponse _$LogoresponseFromJson(Map<String, dynamic> json) => Logoresponse(
      id: json['id'],
      logoImage: json['logo_image'] as String?,
      logoCreatedDate: json['logo_created_date'] as int?,
      logoUpdatedDate: json['logo_updated_date'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$LogoresponseToJson(Logoresponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_image': instance.logoImage,
      'logo_created_date': instance.logoCreatedDate,
      'logo_updated_date': instance.logoUpdatedDate,
      'status': instance.status,
    };
