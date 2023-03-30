import 'package:epub_kit/src/schema/opf/epub_spine.dart';
import 'package:xml/src/xml/builder.dart' show XmlBuilder;

class EpubSpineWriter {
  static void writeSpine(XmlBuilder builder, EpubSpine spine) {
    builder.element('spine', attributes: {'toc': spine.tableOfContents!},
        nest: () {
      spine.items!.forEach((spineitem) => builder.element('itemref',
              attributes: {
                'idref': spineitem.idRef!,
                'linear': spineitem.isLinear! ? 'no' : 'yes'
              }));
    });
  }
}
