import 'package:epub_kit/epub_kit.dart';
import 'package:epub_kit/src/entities/epub_schema.dart';
import 'package:test/test.dart';

main() async {
  var reference = new EpubBook();
  reference
    ..author = "orthros"
    ..authors = ["orthros"]
    ..chapters = [new EpubChapter()]
    ..content = new EpubContent()
    ..coverImage = Image(width: 100, height: 100).getBytes()
    ..schema = new EpubSchema()
    ..title = "A Dissertation on Epubs";

  late EpubBook testBook;
  setUp(() async {
    testBook = new EpubBook();
    testBook
      ..author = "orthros"
      ..authors = ["orthros"]
      ..chapters = [new EpubChapter()]
      ..content = new EpubContent()
      ..coverImage = Image(width: 100, height: 100).getBytes()
      ..schema = new EpubSchema()
      ..title = "A Dissertation on Epubs";
  });

  group("EpubBook", () {
    group(".equals", () {
      test("is true for equivalent objects", () async {
        expect(testBook, equals(reference));
      });

      test("is false when Content changes", () async {
        var file = new EpubTextContentFile();
        file
          ..content = "Hello"
          ..contentMimeType = "application/txt"
          ..contentType = EpubContentType.other
          ..fileName = "orthros.txt";

        EpubContent content = new EpubContent();
        content.allFiles["hello"] = file;
        testBook.content = content;

        expect(testBook, isNot(reference));
      });

      test("is false when Author changes", () async {
        testBook.author = "NotOrthros";
        expect(testBook, isNot(reference));
      });

      test("is false when AuthorList changes", () async {
        testBook.authors = ["NotOrthros"];
        expect(testBook, isNot(reference));
      });

      test("is false when Chapters changes", () async {
        var chapter = new EpubChapter();
        chapter
          ..title = "A Brave new Epub"
          ..contentFileName = "orthros.txt";
        testBook.chapters = [chapter];
        expect(testBook, isNot(reference));
      });

      test("is false when CoverImage changes", () async {
        testBook.coverImage = Image(width: 200, height: 200).getBytes();
        expect(testBook, isNot(reference));
      });

      test("is false when Schema changes", () async {
        var schema = new EpubSchema();
        schema.contentDirectoryPath = "some/random/path";
        testBook.schema = schema;
        expect(testBook, isNot(reference));
      });

      test("is false when Title changes", () async {
        testBook.title = "The Philosophy of Epubs";
        expect(testBook, isNot(reference));
      });
    });

    group(".hashCode", () {
      test("is true for equivalent objects", () async {
        expect(testBook.hashCode, equals(reference.hashCode));
      });

      test("is false when Content changes", () async {
        var file = new EpubTextContentFile();
        file
          ..content = "Hello"
          ..contentMimeType = "application/txt"
          ..contentType = EpubContentType.other
          ..fileName = "orthros.txt";

        EpubContent content = new EpubContent();
        content.allFiles["hello"] = file;
        testBook.content = content;

        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when Author changes", () async {
        testBook.author = "NotOrthros";
        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when AuthorList changes", () async {
        testBook.authors = ["NotOrthros"];
        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when Chapters changes", () async {
        var chapter = new EpubChapter();
        chapter
          ..title = "A Brave new Epub"
          ..contentFileName = "orthros.txt";
        testBook.chapters = [chapter];
        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when CoverImage changes", () async {
        testBook.coverImage = Image(width: 200, height: 200).getBytes();
        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when Schema changes", () async {
        var schema = new EpubSchema();
        schema.contentDirectoryPath = "some/random/path";
        testBook.schema = schema;
        expect(testBook.hashCode, isNot(reference.hashCode));
      });

      test("is false when Title changes", () async {
        testBook.title = "The Philosophy of Epubs";
        expect(testBook.hashCode, isNot(reference.hashCode));
      });
    });
  });
}
