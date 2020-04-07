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
  String thumb;
  List<String> content;
  List<String> like;
  List<String> save;
  String sub_category_id;
  String title;
  String user_id;

  Post(this.category_id, this.content, this.like, this.thumb,
      this.save, this.sub_category_id, this.title, this.user_id);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

   Map<String, dynamic> toJson() => _$PostToJson(this);
 }