import 'package:json_annotation/json_annotation.dart';

part 'companyname_response.g.dart';

@JsonSerializable()
class CompanynameResponse {
  int? id;
  @JsonKey(name: 'company_name')
  String? companyName;
  @JsonKey(name: 'companyname_created_date')
  dynamic companynameCreatedDate;
  @JsonKey(name: 'companyname_update_date')
  dynamic companynameUpdateDate;

  CompanynameResponse({
    this.id,
    this.companyName,
    this.companynameCreatedDate,
    this.companynameUpdateDate,
  });

  factory CompanynameResponse.fromJson(Map<String, dynamic> json) {
    return _$CompanynameResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompanynameResponseToJson(this);
}
