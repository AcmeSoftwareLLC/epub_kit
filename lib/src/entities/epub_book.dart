import 'dart:typed_data';

import 'package:quiver/collection.dart' as collections;
import 'package:quiver/core.dart';

import 'epub_chapter.dart';
import 'epub_content.dart';
import 'epub_schema.dart';

class EpubBook {
  String? title;
  String? author;
  List<String?>? authors;
  EpubSchema? schema;
  EpubContent? content;
  Uint8List? coverImage;
  List<EpubChapter>? chapters;

  @override
  int get hashCode {
    var objects = [
      title.hashCode,
      author.hashCode,
      schema.hashCode,
      content.hashCode,
      coverImage.hashCode,
      ...authors?.map((author) => author.hashCode) ?? [0],
      ...chapters?.map((chapter) => chapter.hashCode) ?? [0],
    ];
    return hashObjects(objects);
  }

  @override
  bool operator ==(other) {
    if (!(other is EpubBook)) {
      return false;
    }

    return title == other.title &&
        author == other.author &&
        collections.listsEqual(authors, other.authors) &&
        schema == other.schema &&
        content == other.content &&
        collections.listsEqual(coverImage!, other.coverImage!) &&
        collections.listsEqual(chapters, other.chapters);
  }
}
