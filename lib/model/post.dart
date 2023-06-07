class Post{
String id,media_url,media_type,description,user_id;
int time_Stamp;

//<editor-fold desc="Data Methods">
  Post({
    required this.id,
    required this.media_url,
    required this.media_type,
    required this.description,
    required this.user_id,
    required this.time_Stamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          media_url == other.media_url &&
          media_type == other.media_type &&
          description == other.description &&
          user_id == other.user_id &&
          time_Stamp == other.time_Stamp);

  @override
  int get hashCode =>
      id.hashCode ^
      media_url.hashCode ^
      media_type.hashCode ^
      description.hashCode ^
      user_id.hashCode ^
      time_Stamp.hashCode;

  @override
  String toString() {
    return 'Post{' +
        ' id: $id,' +
        ' media_url: $media_url,' +
        ' media_type: $media_type,' +
        ' descrition: $description,' +
        ' user_id: $user_id,' +
        ' time_Stamp: $time_Stamp,' +
        '}';
  }

  Post copyWith({
    String? id,
    String? media_url,
    String? media_type,
    String? descrition,
    String? user_id,
    int? time_Stamp,
  }) {
    return Post(
      id: id ?? this.id,
      media_url: media_url ?? this.media_url,
      media_type: media_type ?? this.media_type,
      description: descrition ?? this.description,
      user_id: user_id ?? this.user_id,
      time_Stamp: time_Stamp ?? this.time_Stamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'media_url': this.media_url,
      'media_type': this.media_type,
      'descrition': this.description,
      'user_id': this.user_id,
      'time_Stamp': this.time_Stamp,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      media_url: map['media_url'] as String,
      media_type: map['media_type'] as String,
      description: map['descrition'] as String,
      user_id: map['user_id'] as String,
      time_Stamp: map['time_Stamp'] as int,
    );
  }

//</editor-fold>
}