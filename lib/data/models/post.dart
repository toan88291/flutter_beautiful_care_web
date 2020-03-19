import 'package:flutter_beautiful_care_web/data/models/media.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {

  @JsonKey(
      ignore: true
  )
  String docId;
  String category;
  String sub_category;
  String category_id;
  List<String> content;
  String image;
  List<String> like;
  Media media;
  List<String> save;
  String sub_category_id;
  String title;
  String user_id;

  Post(this.category_id, this.content, this.image, this.like, this.media,
      this.save, this.sub_category_id, this.title, this.user_id);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

   Map<String, dynamic> toJson() => _$PostToJson(this);
 }