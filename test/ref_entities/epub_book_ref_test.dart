import 'package:archive/archive.dart';
import 'package:epub_kit/epub_kit.dart';
import 'package:epub_kit/src/entities/epub_schema.dart';
import 'package:epub_kit/src/ref_entities/epub_content_ref.dart';
import 'package:epub_kit/src/ref_entities/epub_text_content_file_ref.dart';
import 'package:test/test.dart';

main() async {
  Archive arch = new Archive();
  var reference = new EpubBookRef(arch);
  reference
    ..author = "orthros"
    ..authors = ["orthros"]
    ..schema = new EpubSchema()
    ..title = "A Dissertation on Epubs";

  late EpubBookRef testBookRef;
  setUp(() async {
    testBookRef = new EpubBookRef(arch);
    testBookRef
      ..author = "orthros"
      ..authors = ["orthros"]
      ..schema = new EpubSchema()
      ..title = "A Dissertation on Epubs";
  });

  group("EpubBookRef", () {
    group(".equals", () {
      test("is true for equivalent objects", () async {
        expect(testBookRef, equals(reference));
      });

      test("is false when Content changes", () async {
        var file = new EpubTextContentFileRef(testBookRef);
        file
          ..contentMimeType = "application/txt"
          ..contentType = EpubContentType.other
          ..fileName = "orthros.txt";

        EpubContentRef content = new EpubContentRef();
        content.allFiles!["hello"] = file;

        testBookRef.content = content;

        expect(testBookRef, isNot(reference));
      });

      test("is false when Author changes", () async {
        testBookRef.author = "NotOrthros";
        expect(testBookRef, isNot(reference));
      });

      test("is false when AuthorList changes", () async {
        testBookRef.authors = ["NotOrthros"];
        expect(testBookRef, isNot(reference));
      });

      test("is false when Schema changes", () async {
        var schema = new EpubSchema();
        schema.contentDirectoryPath = "some/random/path";
        testBookRef.schema = schema;
        expect(testBookRef, isNot(reference));
      });

      test("is false when Title changes", () async {
        testBookRef.title = "The Philosophy of Epubs";
        expect(testBookRef, isNot(reference));
      });
    });

    group(".hashCode", () {
      test("is true for equivalent objects", () async {
        expect(testBookRef.hashCode, equals(reference.hashCode));
      });

      test("is false when Content changes", () async {
        var file = new EpubTextContentFileRef(testBookRef);
        file
          ..contentMimeType = "application/txt"
          ..contentType = EpubContentType.other
          ..fileName = "orthros.txt";

        EpubContentRef content = new EpubContentRef();
        content.allFiles!["hello"] = file;

        testBookRef.content = content;

        expect(testBookRef, isNot(reference));
      });

      test("is false when Author changes", () async {
        testBookRef.author = "NotOrthros";
        expect(testBookRef.hashCode, isNot(reference.hashCode));
      });

      test("is false when AuthorList changes", () async {
        testBookRef.authors = ["NotOrthros"];
        expect(testBookRef.hashCode, isNot(reference.hashCode));
      });
      test("is false when Schema changes", () async {
        var schema = new EpubSchema();
        schema.contentDirectoryPath = "some/random/path";
        testBookRef.schema = schema;
        expect(testBookRef.hashCode, isNot(reference.hashCode));
      });

      test("is false when Title changes", () async {
        testBookRef.title = "The Philosophy of Epubs";
        expect(testBookRef.hashCode, isNot(reference.hashCode));
      });
    });
  });
}
