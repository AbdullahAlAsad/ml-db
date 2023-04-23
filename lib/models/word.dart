import 'dart:core';

class Word {
  final String? word;
  final String? sentiment;
  final String? group;

  Word({this.word, this.sentiment, this.group});

  factory Word.fromJson(Map<String, dynamic> json) {
    String grp = json['class'];
    grp = grp
        .replaceAll(RegExp(r'[0-9]'), '')
        .replaceAll(".", "")
        .replaceAll("()", "")
        .replaceAll(RegExp('.*?:'), "")
        .replaceAll(RegExp('-.*'), '')
        .replaceFirstMapped(RegExp(r'^.'), (match) => match[0]!.toUpperCase())
        .trim();
    return Word(
        word: json['word'] as String,
        sentiment: json['sentiment'] as String,
        group: grp //json['class'] as String,
        );
  }

  Map<String, dynamic> toJson() {
    return {'word': word, 'sentiment': sentiment, 'class': group};
  }
}
