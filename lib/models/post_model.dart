import 'package:flutter/foundation.dart';

@immutable
class Post {
  final String id;
  final String uid;
  final String text;
  final String link;
  final List<String> imageLinks;
  final String postType; // "text" or "image"
  final List<String> likesIds;
  final List<String> commentIds;
  final String shareType; // "public" or "partners"
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Post({
    required this.id,
    required this.uid,
    required this.text,
    required this.link,
    required this.imageLinks,
    required this.postType,
    required this.createdAt,
    this.updatedAt,
    required this.likesIds,
    required this.commentIds,
    required this.shareType,
  });

  Post copyWith({
    String? id,
    String? uid,
    String? text,
    String? link,
    List<String>? imageLinks,
    String? postType,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? likesIds,
    List<String>? commentIds,
    String? shareType,
  }) {
    return Post(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      text: text ?? this.text,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesIds: likesIds ?? this.likesIds,
      commentIds: commentIds ?? this.commentIds,
      shareType: shareType ?? this.shareType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'text': text});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'postType': postType});
    result.addAll({'likesIds': likesIds});
    result.addAll({'commentIds': commentIds});
    result.addAll({'shareType': shareType});
    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['\$id'],
      uid: map['uid'],
      text: map['text'],
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      postType: map['postType'] as String,
      createdAt: DateTime.parse(map['\$createdAt']),
      updatedAt:
          map['\$updatedAt'] != null
              ? DateTime.parse(map['\$updatedAt'])
              : null,
      likesIds: List<String>.from(map['likesIds']),
      commentIds: List<String>.from(map['commentIds']),
      shareType: map['shareType'] as String,
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, uid: $uid, text: $text, link: $link, imageLinks: $imageLinks, postType: $postType, createdAt: $createdAt, updatedAt: $updatedAt, likesIds: $likesIds, commentIds: $commentIds, shareType: $shareType)';
  }
}
