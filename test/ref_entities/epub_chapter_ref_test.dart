import 'package:archive/archive.dart';
import 'package:epub_kit/epub_kit.dart';
import 'package:epub_kit/src/ref_entities/epub_text_content_file_ref.dart';
import 'package:test/test.dart';

Future<void> main() async {
  var arch = new Archive();
  var bookRef = new EpubBookRef(arch);
  var contentFileRef = new EpubTextContentFileRef(bookRef);
  var reference = new EpubChapterRef(contentFileRef);

  reference
    ..anchor = "anchor"
    ..contentFileName = "orthros"
    ..subChapters = []
    ..title = "A New Look at Chapters";

  late EpubBookRef bookRef2;
  late EpubChapterRef testChapterRef;
  setUp(() async {
    var arch2 = new Archive();
    bookRef2 = new EpubBookRef(arch2);
    var contentFileRef2 = new EpubTextContentFileRef(bookRef2);

    testChapterRef = new EpubChapterRef(contentFileRef2);
    testChapterRef
      ..anchor = "anchor"
      ..contentFileName = "orthros"
      ..subChapters = []
      ..title = "A New Look at Chapters";
  });

  group("EpubChapterRef", () {
    group(".equals", () {
      test("is true for equivalent objects", () async {
        expect(testChapterRef, equals(reference));
      });

      test("is false when Anchor changes", () async {
        testChapterRef.anchor = "NotAnAnchor";
        expect(testChapterRef, isNot(reference));
      });

      test("is false when ContentFileName changes", () async {
        testChapterRef.contentFileName = "NotOrthros";
        expect(testChapterRef, isNot(reference));
      });

      test("is false when SubChapters changes", () async {
        var subchapterContentFileRef = new EpubTextContentFileRef(bookRef2);
        var chapter = new EpubChapterRef(subchapterContentFileRef);
        chapter
          ..title = "A Brave new Epub"
          ..contentFileName = "orthros.txt";
        testChapterRef.subChapters = [chapter];
        expect(testChapterRef, isNot(reference));
      });

      test("is false when Title changes", () async {
        testChapterRef.title = "A Boring Old World";
        expect(testChapterRef, isNot(reference));
      });
    });

    group(".hashCode", () {
      test("is true for equivalent objects", () async {
        expect(testChapterRef.hashCode, equals(reference.hashCode));
      });

      test("is true for equivalent objects", () async {
        expect(testChapterRef.hashCode, equals(reference.hashCode));
      });

      test("is false when Anchor changes", () async {
        testChapterRef.anchor = "NotAnAnchor";
        expect(testChapterRef.hashCode, isNot(reference.hashCode));
      });

      test("is false when ContentFileName changes", () async {
        testChapterRef.contentFileName = "NotOrthros";
        expect(testChapterRef.hashCode, isNot(reference.hashCode));
      });

      test("is false when SubChapters changes", () async {
        var subchapterContentFileRef = new EpubTextContentFileRef(bookRef2);
        var chapter = new EpubChapterRef(subchapterContentFileRef);
        chapter
          ..title = "A Brave new Epub"
          ..contentFileName = "orthros.txt";
        testChapterRef.subChapters = [chapter];
        expect(testChapterRef, isNot(reference));
      });

      test("is false when Title changes", () async {
        testChapterRef.title = "A Boring Old World";
        expect(testChapterRef.hashCode, isNot(reference.hashCode));
      });
    });
  });
}
