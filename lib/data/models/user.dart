import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  @JsonKey(
      ignore: true
  )
  String docId;

  String username;

  String password;

  String fullname;

  bool role;


  User(this.username, this.password, this.fullname, this.role);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   Map<String, dynamic> toJson() => _$UserToJson(this);
 }