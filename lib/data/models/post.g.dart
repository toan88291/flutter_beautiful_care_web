// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['category_id'] as String,
    (json['content'] as List)?.map((e) => e as String)?.toList(),
    json['image'] as String,
    (json['like'] as List)?.map((e) => e as String)?.toList(),
    json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    (json['save'] as List)?.map((e) => e as String)?.toList(),
    json['sub_category_id'] as String,
    json['title'] as String,
    json['user_id'] as String,
  )
    ..category = json['category'] as String
    ..sub_category = json['sub_category'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'category': instance.category,
      'sub_category': instance.sub_category,
      'category_id': instance.category_id,
      'content': instance.content,
      'image': instance.image,
      'like': instance.like,
      'media': instance.media,
      'save': instance.save,
      'sub_category_id': instance.sub_category_id,
      'title': instance.title,
      'user_id': instance.user_id,
    };
