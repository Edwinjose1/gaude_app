// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: json['id'] as int?,
      categoryName: json['category_name'] as String?,
      categoryCreateDate: json['category_create_date'] == null
          ? null
          : DateTime.parse(json['category_create_date'] as String),
      categoryUpdateDate: json['category_update_date'],
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_name': instance.categoryName,
      'category_create_date': instance.categoryCreateDate?.toIso8601String(),
      'category_update_date': instance.categoryUpdateDate,
    };
