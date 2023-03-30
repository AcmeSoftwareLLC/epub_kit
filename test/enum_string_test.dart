library epubtest;

import 'package:test/test.dart';

import 'package:epub_kit/epub_kit.dart';

main() {
  test("Enum One", () {
    expect(new EnumFromString<Simple>(Simple.values).get("ONE"),
        equals(Simple.one));
  });
  test("Enum Two", () {
    expect(new EnumFromString<Simple>(Simple.values).get("TWO"),
        equals(Simple.two));
  });
  test("Enum One", () {
    expect(new EnumFromString<Simple>(Simple.values).get("THREE"),
        equals(Simple.three));
  });
  test("Enum One Lower Case", () {
    expect(new EnumFromString<Simple>(Simple.values).get("one"),
        equals(Simple.one));
  });
}

enum Simple { one, two, three }
