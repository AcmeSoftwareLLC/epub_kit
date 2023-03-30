import 'package:epub_kit/src/schema/opf/epub_manifest.dart';
import 'package:xml/src/xml/builder.dart' show XmlBuilder;

class EpubManifestWriter {
  static void writeManifest(XmlBuilder builder, EpubManifest? manifest) {
    builder.element('manifest', nest: () {
      manifest!.items!.forEach((item) {
        builder.element('item', nest: () {
          builder
            ..attribute('id', item.id!)
            ..attribute('href', item.href!)
            ..attribute('media-type', item.mediaType!);
          if (item.properties != null) {
            builder.attribute('properties', item.properties!);
          }
        });
      });
    });
  }
}
