// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return Media(
    json['height'] as int,
    json['width'] as int,
    json['url'] as String,
    json['type'] as bool,
  );
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
      'type': instance.type,
    };
