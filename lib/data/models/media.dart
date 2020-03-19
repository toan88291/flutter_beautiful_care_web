import 'package:json_annotation/json_annotation.dart';
part 'media.g.dart';

@JsonSerializable()
class Media {
    @JsonKey(
        ignore: true
    )
    String docId;

    int height;
    int width;
    String url;
    bool type;

    Media(this.height, this.width, this.url, this.type);

    factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

   Map<String, dynamic> toJson() => _$MediaToJson(this);
 }