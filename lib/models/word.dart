import 'dart:core';

class Word {
  final String? word;
  final String? sentiment;
  final String? group;

  Word({this.word, this.sentiment, this.group});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'] as String,
      sentiment: json['sentiment'] as String,
      group: json['class'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'word': word, 'sentiment': sentiment, 'class': group};
  }
}
