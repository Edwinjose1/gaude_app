import 'package:json_annotation/json_annotation.dart';

part 'logoresponse.g.dart';

@JsonSerializable()
class Logoresponse {
  @JsonKey(name: 'id')
  dynamic id;
  @JsonKey(name: 'logo_image')
  String? logoImage;
  @JsonKey(name: 'logo_created_date')
  int? logoCreatedDate;
  @JsonKey(name: 'logo_updated_date')
  int? logoUpdatedDate;
  @JsonKey(name: 'status')
  int? status;

  Logoresponse({
    this.id,
    this.logoImage,
    this.logoCreatedDate,
    this.logoUpdatedDate,
    this.status,
  });

  factory Logoresponse.fromJson(Map<String, dynamic> json) {
    return _$LogoresponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LogoresponseToJson(this);
}
