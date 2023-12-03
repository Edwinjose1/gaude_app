import 'package:json_annotation/json_annotation.dart';

part 'classification_response.g.dart';

@JsonSerializable()
class ClassificationResponse {
  int? id;
  @JsonKey(name: 'classification_name')
  String? classificationName;
  @JsonKey(name: 'classificatioin_create_date')
  DateTime? classificatioinCreateDate;
  @JsonKey(name: 'classification_update_date')
  dynamic classificationUpdateDate;

  ClassificationResponse({
    this.id,
    this.classificationName,
    this.classificatioinCreateDate,
    this.classificationUpdateDate,
  });

  factory ClassificationResponse.fromJson(Map<String, dynamic> json) {
    return _$ClassificationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClassificationResponseToJson(this);
}
