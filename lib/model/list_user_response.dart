import 'package:flutter_dio/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_user_response.g.dart';
@JsonSerializable()
class ListUserResponse{
  @JsonKey(name:"page")
  late int page;

  @JsonKey(name:"per_page")
  late int perPage;

  @JsonKey(name:"total")
  late int total;

  @JsonKey(name:"total_pages")
  late int totalPages;

  @JsonKey(name:"data")
  late List<User>users;

  ListUserResponse();

  factory ListUserResponse.fromJson(Map<String, dynamic> json) => _$ListUserResponseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ListUserResponseToJson(this);
}