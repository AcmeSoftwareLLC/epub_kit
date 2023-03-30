import '../entities/epub_content_type.dart';
import '../ref_entities/epub_book_ref.dart';
import '../ref_entities/epub_byte_content_file_ref.dart';
import '../ref_entities/epub_content_file_ref.dart';
import '../ref_entities/epub_content_ref.dart';
import '../ref_entities/epub_text_content_file_ref.dart';
import '../schema/opf/epub_manifest_item.dart';

class ContentReader {
  static EpubContentRef parseContentMap(EpubBookRef bookRef) {
    var result = EpubContentRef();
    result.html = <String, EpubTextContentFileRef>{};
    result.css = <String, EpubTextContentFileRef>{};
    result.images = <String, EpubByteContentFileRef>{};
    result.fonts = <String, EpubByteContentFileRef>{};
    result.allFiles = <String, EpubContentFileRef>{};

    bookRef.schema!.package!.manifest!.items!
        .forEach((EpubManifestItem manifestItem) {
      var fileName = manifestItem.href;
      var contentMimeType = manifestItem.mediaType!;
      var contentType = getContentTypeByContentMimeType(contentMimeType);
      switch (contentType) {
        case EpubContentType.xhtml:
        case EpubContentType.css:
        case EpubContentType.oeb1Document:
        case EpubContentType.oeb1Css:
        case EpubContentType.xml:
        case EpubContentType.dtbook:
        case EpubContentType.dtbookNcx:
          var epubTextContentFile = EpubTextContentFileRef(bookRef);
          {
            epubTextContentFile.fileName = Uri.decodeFull(fileName!);
            epubTextContentFile.contentMimeType = contentMimeType;
            epubTextContentFile.contentType = contentType;
          }
          ;
          switch (contentType) {
            case EpubContentType.xhtml:
              result.html![fileName] = epubTextContentFile;
              break;
            case EpubContentType.css:
              result.css![fileName] = epubTextContentFile;
              break;
            case EpubContentType.dtbook:
            case EpubContentType.dtbookNcx:
            case EpubContentType.oeb1Document:
            case EpubContentType.xml:
            case EpubContentType.oeb1Css:
            case EpubContentType.imageGIF:
            case EpubContentType.imageJPEG:
            case EpubContentType.imagePNG:
            case EpubContentType.imageSVG:
            case EpubContentType.fontTrueType:
            case EpubContentType.fontOpenType:
            case EpubContentType.other:
              break;
          }
          result.allFiles![fileName] = epubTextContentFile;
          break;
        default:
          var epubByteContentFile = EpubByteContentFileRef(bookRef);
          {
            epubByteContentFile.fileName = Uri.decodeFull(fileName!);
            epubByteContentFile.contentMimeType = contentMimeType;
            epubByteContentFile.contentType = contentType;
          }
          ;
          switch (contentType) {
            case EpubContentType.imageGIF:
            case EpubContentType.imageJPEG:
            case EpubContentType.imagePNG:
            case EpubContentType.imageSVG:
              result.images![fileName] = epubByteContentFile;
              break;
            case EpubContentType.fontTrueType:
            case EpubContentType.fontOpenType:
              result.fonts![fileName] = epubByteContentFile;
              break;
            case EpubContentType.css:
            case EpubContentType.xhtml:
            case EpubContentType.dtbook:
            case EpubContentType.dtbookNcx:
            case EpubContentType.oeb1Document:
            case EpubContentType.xml:
            case EpubContentType.oeb1Css:
            case EpubContentType.other:
              break;
          }
          result.allFiles![fileName] = epubByteContentFile;
          break;
      }
    });
    return result;
  }

  static EpubContentType getContentTypeByContentMimeType(
      String contentMimeType) {
    switch (contentMimeType.toLowerCase()) {
      case 'application/xhtml+xml':
        return EpubContentType.xhtml;
      case 'application/x-dtbook+xml':
        return EpubContentType.dtbook;
      case 'application/x-dtbncx+xml':
        return EpubContentType.dtbookNcx;
      case 'text/x-oeb1-document':
        return EpubContentType.oeb1Document;
      case 'application/xml':
        return EpubContentType.xml;
      case 'text/css':
        return EpubContentType.css;
      case 'text/x-oeb1-css':
        return EpubContentType.oeb1Css;
      case 'image/gif':
        return EpubContentType.imageGIF;
      case 'image/jpeg':
        return EpubContentType.imageJPEG;
      case 'image/png':
        return EpubContentType.imagePNG;
      case 'image/svg+xml':
        return EpubContentType.imageSVG;
      case 'font/truetype':
        return EpubContentType.fontTrueType;
      case 'font/opentype':
        return EpubContentType.fontOpenType;
      case 'application/vnd.ms-opentype':
        return EpubContentType.fontOpenType;
      default:
        return EpubContentType.other;
    }
  }
}
