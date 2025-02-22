import 'epub_book_ref.dart';
import 'epub_content_file_ref.dart';

class EpubTextContentFileRef extends EpubContentFileRef {
  EpubTextContentFileRef(EpubBookRef epubBookRef) : super(epubBookRef);

  String readContentAsync() => readContentAsText();
}
