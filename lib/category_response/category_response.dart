import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  int? id;
  @JsonKey(name: 'category_name')
  String? categoryName;
  @JsonKey(name: 'category_create_date')
  DateTime? categoryCreateDate;
  @JsonKey(name: 'category_update_date')
  dynamic categoryUpdateDate;

  CategoryResponse({
    this.id,
    this.categoryName,
    this.categoryCreateDate,
    this.categoryUpdateDate,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
